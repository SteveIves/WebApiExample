<CODEGEN_FILENAME><StructureName>.dbl</CODEGEN_FILENAME>
<CODEGEN_FOLDER>Models</CODEGEN_FOLDER>
<PROCESS_TEMPLATE>DataClassBase</PROCESS_TEMPLATE>

namespace <NAMESPACE>

    .include "<STRUCTURE_NOALIAS>" repository, structure="str<StructureName>", end

    ;;; <summary>
    ;;; <STRUCTURE_DESC>
    ;;; </summary>
    public partial class <StructureName> extends DataClassBase

        ;;; <summary>
        ;;; Construct an empty <StructureName> object
        ;;; </summary>
        public method <StructureName>
        proc
        endmethod

        ;;; <summary>
        ;;; Construct a <StructureName> object from a <STRUCTURE_DESC> record
        ;;; </summary>
        public method <StructureName>
            required in a<StructureName>, str<StructureName>
        proc
            <FIELD_LOOP>
            <IF ALPHA>
            this.<FieldName> = %atrim(a<StructureName>.<field_name>)
            </IF ALPHA>
            <IF DECIMAL>
            this.<FieldName> = a<StructureName>.<field_name>
            </IF DECIMAL>
            <IF DATE>
            <IF DATE_NOT_NULLABLE>
            this.<FieldName> = yyyymmddToDateTime(a<StructureName>.<field_name>)
            <ELSE>
            this.<FieldName> = yyyymmddToNullableDateTime(a<StructureName>.<field_name>)
            </IF DATE_NOT_NULLABLE>
            </IF DATE>
            <IF TIME_HHMM>
            this.<FieldName> = hhmmToDateTime(a<StructureName>.<field_name>)
            </IF TIME_HHMM>
            <IF TIME_HHMMSS>
            this.<FieldName> = hghmmssToDateTime(a<StructureName>.<field_name>)
            </IF TIME_HHMMSS>
            <IF INTEGER>
            this.<FieldName> = a<StructureName>.<field_name>
            </IF INTEGER>
            </FIELD_LOOP>
        endmethod

        <FIELD_LOOP>
        ;;; <summary>
        ;;; <FIELD_DESC>
        ;;; </summary>
        public readwrite property <FieldName>, <FIELD_SNTYPE>

        </FIELD_LOOP>
        ;;; <summary>
        ;;; Return the data as a <STRUCTURE_DESC> record
        ;;; </summary>
        public method ToRecord, str<StructureName>
        proc
            data <structureName>Rec, str<StructureName>
            <FIELD_LOOP>
            <IF ALPHA>
            <structureName>Rec.<field_name> = this.<FieldName>
            </IF ALPHA>
            <IF DECIMAL>
            <structureName>Rec.<field_name> = this.<FieldName>
            </IF DECIMAL>
            <IF DATE>
            <IF DATE_NOT_NULLABLE>
            <structureName>Rec.<field_name> = dateTimeToYYYYMMDD(this.<FieldName>)
            <ELSE>
            <structureName>Rec.<field_name> = nullableDateTimeToYYYYMMDD(this.<FieldName>)
            </IF DATE_NOT_NULLABLE>
            </IF DATE>
            <IF TIME_HHMM>
            <structureName>Rec.<field_name> = dateTimeToHHMM(this.<FieldName>)
            </IF TIME_HHMM>
            <IF TIME_HHMMSS>
            <structureName>Rec.<field_name> = dateTimeToHHMMSS(this.<FieldName>)
            </IF TIME_HHMMSS>
            <IF INTEGER>
            <structureName>Rec.<field_name> = this.<FieldName>
            </IF INTEGER>
            </FIELD_LOOP>
            mreturn <structureName>Rec
        endmethod

    endclass

endnamespace