<CODEGEN_FILENAME><StructureName>Repository.dbl</CODEGEN_FILENAME>
<CODEGEN_FOLDER>Models</CODEGEN_FOLDER>
<PROCESS_TEMPLATE>DataClass</PROCESS_TEMPLATE>
<PROCESS_TEMPLATE>RepositoryInterface</PROCESS_TEMPLATE>

import System.Collections.Generic
import Synergex.SynergyDE.Select

namespace <NAMESPACE>

    ;;; <summary>
    ;;; Data repository for the <FILE_DESC> (<FILE_NAME>)
    ;;; </summary>
    public partial class <StructureName>Repository implements I<StructureName>Repository

        private const fileSpec, string, "<FILE_NAME>"

        ;;; <summary>
        ;;; Read all records.
        ;;; </summary>
        ;;; <param name="results">Returned collection of records.</param>
        ;;; <returns>RepositoryResult.Success or RepositoryResult.NotFound</returns>
        public method ReadAll, RepositoryResult
            required out results, @List<<StructureName>>
        proc
            results = new List<<StructureName>>()
            data <structureName>Rec, str<StructureName>
            foreach <structureName>Rec in new Select(new From(fileSpec,<structureName>Rec))
                results.Add(new <StructureName>(<structureName>Rec))
            mreturn results.Count > 0 ? RepositoryResult.Success : RepositoryResult.NotFound
        endmethod

        ;;; <summary>
        ;;; Read a specific record by primary key.
        ;;; </summary>
        <PRIMARY_KEY>
        <SEGMENT_LOOP>
        ;;; <param name="a<SegmentName>"><SEGMENT_DESC></param>
        </SEGMENT_LOOP>
        </PRIMARY_KEY>
        ;;; <param name="a<StructureName>">Returned data object.</param>
        ;;; <returns>RepositoryResult.Success or RepositoryResult.NotFound</returns>
        public method Read, RepositoryResult
            <PRIMARY_KEY>
            <SEGMENT_LOOP>
            required in a<SegmentName>, <SEGMENT_SNTYPE>
            </SEGMENT_LOOP>
            </PRIMARY_KEY>
            required out a<StructureName>, @<StructureName>
        proc
            data <structureName>Rec, str<StructureName>
            foreach <structureName>Rec in new Select(new From(fileSpec,<structureName>Rec),(Where)(<PRIMARY_KEY><SEGMENT_LOOP>(<structureName>Rec.<segment_name>==a<SegmentName>)<&&></SEGMENT_LOOP></PRIMARY_KEY>))
            begin
                a<StructureName> = new <StructureName>(<structureName>Rec)
                mreturn RepositoryResult.Success
            end
            mreturn RepositoryResult.NotFound
        endmethod
        
        <ALTERNATE_KEY_LOOP>
        ;;; <summary>
        ;;; Retrieve all <structure_name>s by <KEY_NAME>.
        ;;; </summary>
        <SEGMENT_LOOP>
        ;;; <param name="a<SegmentName>"><SEGMENT_DESC>.</param>
        </SEGMENT_LOOP>
        ;;; <param name="results">Returned collection of records.</param>
        ;;; <returns>RepositoryResult.Success or RepositoryResult.NotFound</returns>
        public method ReadBy<KEY_NAME>, RepositoryResult
            <SEGMENT_LOOP>
            required in  a<SegmentName>, <SEGMENT_SNTYPE>
            </SEGMENT_LOOP>
            required out results, @List<<StructureName>>
        proc
            results = new List<<StructureName>>()
            data <structureName>Rec, str<StructureName>
            foreach <structureName>Rec in new Select(new From(fileSpec,<structureName>Rec),(NoCaseWhere)(<SEGMENT_LOOP>(<structureName>Rec.<SEGMENT_NAME>==a<SegmentName>)<&&></SEGMENT_LOOP>))
                results.Add(new <StructureName>(<structureName>Rec))
            mreturn results.Count > 0 ? RepositoryResult.Success : RepositoryResult.NotFound
        endmethod

        </ALTERNATE_KEY_LOOP>
        ;;; <summary>
        ;;; Create a new record.
        ;;; </summary>
        ;;; <param name="<structureName>Obj"><STRUCTURE_DESC>.</param>
        ;;; <returns>RepositoryResult.Success, RepositoryResult.Exists or RepositoryResult.DuplicateKey</returns>
        public method Create, RepositoryResult
            required in <structureName>Obj, @<StructureName>
        proc
            data response, RepositoryResult
            data <structureName>Rec, str<StructureName>, <structureName>Obj.ToRecord()
            data chn, i4

            ;;Open the file
            open(chn=0,U:I,fileSpec)

            ;;Check the record doesn't already exist
            try
            begin
                data tmpRec, str<StructureName>
                read(chn,tmpRec,%keyval(chn,<structureName>Rec,0),LOCK:Q_NO_LOCK)
                response = RepositoryResult.Exists
            end
            catch (e, @KeyNotSameException)
            begin
                nop
            end
            catch (e, @EndOfFileException)
            begin
                nop
            end
            endtry

            ;;Create the new record
            if (response != RepositoryResult.Exists)
            begin
                try
                begin
                    store(chn,<structureName>Rec)
                    response = RepositoryResult.Success
                end
                catch (e, @DuplicateException)
                begin
                    response = RepositoryResult.DuplicateKey
                end
                endtry
            end

            ;;Close the file
            close chn

            mreturn response

        endmethod

        ;;; <summary>
        ;;; Update an existing record.
        ;;; </summary>
        ;;; <param name="<structureName>Obj"><STRUCTURE_DESC>.</param>
        ;;; <returns>RepositoryResult.Success, RepositoryResult.NotFound, RepositoryResult.DuplicateKey or RepositoryResult.KeyChange</returns>
        public method Update, RepositoryResult
            required in <structureName>Obj, @<StructureName>
        proc
            data <structureName>Rec, str<StructureName>, <structureName>Obj.ToRecord()
            data chn, i4
            data response, RepositoryResult
                
            ;;Open the file
            open(chn=0,U:I,fileSpec)

            ;;Read and lock the <structure_name> record
            try
            begin
                data tmpRec, str<StructureName>
                read(chn,tmpRec,%keyval(chn,<structureName>Rec,0))
                try
                begin
                    write(chn,<structureName>Rec)
                    response = RepositoryResult.Success
                end
                catch (e, @DuplicateException)
                begin
                    response = RepositoryResult.DuplicateKey
                end
                catch (e, @KeyNotSameException)
                begin
                    response = RepositoryResult.KeyChange
                end
                endtry
            end
            catch (e, @KeyNotSameException)
            begin
                response = RepositoryResult.NotFound
            end
            catch (e, @EndOfFileException)
            begin
                response = RepositoryResult.NotFound
            end
            endtry

            ;;Close the file
            close chn

            mreturn response

        endmethod
        
        ;;; <summary>
        ;;; Delete a record.
        ;;; </summary>
        <PRIMARY_KEY>
        <SEGMENT_LOOP>
        ;;; <param name="a<SegmentName>"><SEGMENT_DESC></param>
        </SEGMENT_LOOP>
        </PRIMARY_KEY>
        ;;; <returns>RepositoryResult.Success or RepositoryResult.NotFound</returns>
        public method Delete, RepositoryResult
            <PRIMARY_KEY>
            <SEGMENT_LOOP>
            required in a<SegmentName>, <SEGMENT_SNTYPE>
            </SEGMENT_LOOP>
            </PRIMARY_KEY>
        proc
            data response, RepositoryResult
            data chn, i4

            ;;Open the file
            open(chn=0,U:I,fileSpec)

            ;;Put the key segments into <structureName>Rec so we can use %keyval
            data <structureName>Rec, str<StructureName>
            <PRIMARY_KEY>
            <SEGMENT_LOOP>
            <structureName>Rec.<segment_name> = a<SegmentName>
            </SEGMENT_LOOP>
            </PRIMARY_KEY>

            try
            begin
                read(chn,<structureName>Rec,%keyval(chn,<structureName>Rec,0))
                delete(chn)
                response = RepositoryResult.Success
            end
            catch (e, @KeyNotSameException)
            begin
                response = RepositoryResult.NotFound
            end
            catch (e, @EndOfFileException)
            begin
                response = RepositoryResult.NotFound
            end
            endtry

            ;;Close the file
            close chn

            mreturn response

        endmethod
        
    endclass

endnamespace