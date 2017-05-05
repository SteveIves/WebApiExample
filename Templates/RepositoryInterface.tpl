<CODEGEN_FILENAME>I<StructureName>Repository.dbl</CODEGEN_FILENAME>
<CODEGEN_FOLDER>Models</CODEGEN_FOLDER>

import System.Collections.Generic

namespace <NAMESPACE>

    partial interface I<StructureName>Repository

        method ReadAll, RepositoryResult
            required out results, @List<<StructureName>>
        endmethod

        method Read, RepositoryResult
            <PRIMARY_KEY>
            <SEGMENT_LOOP>
            required in a<SegmentName>, <SEGMENT_SNTYPE>
            </SEGMENT_LOOP>
            </PRIMARY_KEY>
            required out a<StructureName>, @<StructureName>
        endmethod
        
        <ALTERNATE_KEY_LOOP>
        method ReadBy<KEY_NAME>, RepositoryResult
            <SEGMENT_LOOP>
            required in  a<SegmentName>, <SEGMENT_SNTYPE>
            </SEGMENT_LOOP>
            required out results, @List<<StructureName>>
        endmethod

        </ALTERNATE_KEY_LOOP>
        method Create, RepositoryResult
            required in <structureName>Obj, @<StructureName>
        endmethod

        method Update, RepositoryResult
            required in <structureName>Obj, @<StructureName>
        endmethod
        
        method Delete, RepositoryResult
            <PRIMARY_KEY>
            <SEGMENT_LOOP>
            required in a<SegmentName>, <SEGMENT_SNTYPE>
            </SEGMENT_LOOP>
            </PRIMARY_KEY>
        endmethod
        
    endinterface

endnamespace