<CODEGEN_FILENAME><StructureName>Controller.dbl</CODEGEN_FILENAME>
<CODEGEN_FOLDER>Controllers</CODEGEN_FOLDER>
<PROCESS_TEMPLATE>RepositoryClass</PROCESS_TEMPLATE>
<REQUIRES_USERTOKEN>MODEL_NS</REQUIRES_USERTOKEN>
<PROCESS_TEMPLATE>UnityResolver</PROCESS_TEMPLATE>

import System
import System.Collections.Generic
import System.ComponentModel
import System.Globalization
import System.Linq
import System.Net
import System.Net.Http
import System.Web.Http
import System.ComponentModel.DataAnnotations
import <MODEL_NS>

namespace <NAMESPACE>

    {RoutePrefix("api/<structure_name>")}
    ;;; <summary>
    ;;; A Web API Controller exposing CRUD functionality for the <STRUCTURE_DESC>.
    ;;; </summary>
    public partial class <StructureName>Controller extends ApiController

        private _<structureName>Repo, @I<StructureName>Repository

        public method <StructureName>Controller
			required in injected<StructureName>Repo, @I<StructureName>Repository
        proc
            _<structureName>Repo = injected<StructureName>Repo
        endmethod

        {Route("")}
        ;;; <summary>
        ;;; Retrieve all <structure_name>s.
        ;;; </summary>
        ;;; <returns>A collection of all <structure_name>s.</returns>
        public method GetAll, @HttpResponseMessage
        proc
            data results = new List<<StructureName>>()
            if (_<structureName>Repo.ReadAll(results) == RepositoryResult.NotFound)
                mreturn Request.CreateResponse(HttpStatusCode.NotFound)

            mreturn Request.CreateResponse(HttpStatusCode.OK,results)

        endmethod

        {Route("<PRIMARY_KEY><SEGMENT_LOOP>{a<SegmentName>}<FSLASH></SEGMENT_LOOP></PRIMARY_KEY>")}
        ;;; <summary>
        ;;; Retrieve a specific <structure_name> by <PRIMARY_KEY><SEGMENT_LOOP><SEGMENT_NAME><IF MORE> and </IF></SEGMENT_LOOP></PRIMARY_KEY>.
        ;;; </summary>
        <PRIMARY_KEY>
        <SEGMENT_LOOP>
        ;;; <param name="a<SegmentName>"><SEGMENT_DESC>.</param>
        </SEGMENT_LOOP>
        </PRIMARY_KEY>
        ;;; <returns>Returns a <StructureName> object.</returns>
        public method Get, @HttpResponseMessage
            <PRIMARY_KEY>
            <SEGMENT_LOOP>
            required in a<SegmentName>, <SEGMENT_SNTYPE>
            </SEGMENT_LOOP>
            </PRIMARY_KEY>
        proc
            data <structureName>Obj, @<StructureName>
            if (_<structureName>Repo.Read(<PRIMARY_KEY><SEGMENT_LOOP>a<SegmentName>,</SEGMENT_LOOP></PRIMARY_KEY><structureName>Obj) == RepositoryResult.NotFound)
                mreturn Request.CreateResponse(HttpStatusCode.NotFound)

            mreturn Request.CreateResponse(HttpStatusCode.OK,<structureName>Obj)

        endmethod

        <ALTERNATE_KEY_LOOP>
        {Route("<key_name>/<SEGMENT_LOOP>{a<SegmentName>}<FSLASH></SEGMENT_LOOP>")}
        ;;; <summary>
        ;;; Retrieve all <structure_name>s by <KEY_NAME>.
        ;;; </summary>
        <SEGMENT_LOOP>
        ;;; <param name="a<SegmentName>"><SEGMENT_DESC>.</param>
        </SEGMENT_LOOP>
        ;;; <returns>Returns <structure_name>s by <KEY_NAME>.</returns>
        public method GetBy<KEY_NAME>, @HttpResponseMessage
            <SEGMENT_LOOP>
            required in a<SegmentName>, <SEGMENT_SNTYPE>
            </SEGMENT_LOOP>
        proc
            data results, @List<<StructureName>>
            if (_<structureName>Repo.ReadBy<KEY_NAME>(<SEGMENT_LOOP>a<SegmentName>,</SEGMENT_LOOP>results) == RepositoryResult.NotFound)
                mreturn Request.CreateResponse(HttpStatusCode.NotFound)

            mreturn Request.CreateResponse(HttpStatusCode.OK,results)

        endmethod

        </ALTERNATE_KEY_LOOP>
        {Route("")}
        ;;; <summary>
        ;;; Create a new <structure_name>.
        ;;; </summary>
        ;;; <param name="<structureName>Obj"><StructureName> to create.</param>
        ;;; <returns>Returns an HttpResponseMessage indicating the status of the operation and, on success, containing a URL that can be used to retrieve the <StructureName> object.</returns>
        public method Post, @HttpResponseMessage
            {FromBody()}
            required in <structureName>Obj, @<StructureName>
        proc
            if (_<structureName>Repo.Create(<structureName>Obj) == RepositoryResult.Exists)
                mreturn Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Already exists!")

            data response = Request.CreateResponse(HttpStatusCode.Created)
            response.Headers.Location = new Uri(String.Format("{0}/<PRIMARY_KEY><SEGMENT_LOOP>{<SEGMENT_NUMBER>}<FSLASH></SEGMENT_LOOP></PRIMARY_KEY>",Request.RequestUri,<PRIMARY_KEY><SEGMENT_LOOP><structureName>Obj.<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>))
            mreturn response

        endmethod

        {Route("<PRIMARY_KEY><SEGMENT_LOOP>{a<SegmentName>}<FSLASH></SEGMENT_LOOP></PRIMARY_KEY>")}
        ;;; <summary>
        ;;; Update an existing <structure_name>.
        ;;; </summary>
        <PRIMARY_KEY>
        <SEGMENT_LOOP>
        ;;; <param name="a<SegmentName>"><SEGMENT_DESC>.</param>
        </SEGMENT_LOOP>
        </PRIMARY_KEY>
        ;;; <param name="<structureName>Obj"><StructureName> to update.</param>
        ;;; <returns>Returns an HttpResponseMessage indicating the status of the operation.</returns>
        public method Put, @HttpResponseMessage
            <PRIMARY_KEY>
            <SEGMENT_LOOP>
            required in a<SegmentName>, <SEGMENT_SNTYPE>
            </SEGMENT_LOOP>
            </PRIMARY_KEY>
            {FromBody()}
            required in <structureName>Obj, @<StructureName>
        proc
            ;; Move the parameter data into the data object
            <PRIMARY_KEY>
            <SEGMENT_LOOP>
            <structureName>Obj.<SegmentName> = a<SegmentName>
            </SEGMENT_LOOP>
            </PRIMARY_KEY>

            using (_<structureName>Repo.Update(<structureName>Obj)) select
            (RepositoryResult.NotFound),
                mreturn Request.CreateResponse(HttpStatusCode.NotFound)
            (RepositoryResult.DuplicateKey),
                mreturn Request.CreateErrorResponse(HttpStatusCode.BadRequest,"Invalid duplicate key value!")
            (RepositoryResult.KeyChange),
                mreturn Request.CreateErrorResponse(HttpStatusCode.BadRequest,"Invalid key value change!")
            endusing

            mreturn Request.CreateResponse(HttpStatusCode.NoContent)

        endmethod
        
        {Route("<PRIMARY_KEY><SEGMENT_LOOP>{a<SegmentName>}<FSLASH></SEGMENT_LOOP></PRIMARY_KEY>")}
        ;;; <summary>
        ;;; Delete a <structure_name>.
        ;;; </summary>
        <PRIMARY_KEY>
        <SEGMENT_LOOP>
        ;;; <param name="a<SegmentName>"><SEGMENT_DESC>.</param>
        </SEGMENT_LOOP>
        </PRIMARY_KEY>
        ;;; <returns>Returns an HttpResponseMessage indicating the status of the operation.</returns>
        public method Delete, @HttpResponseMessage
            <PRIMARY_KEY>
            <SEGMENT_LOOP>
            required in a<SegmentName>, <SEGMENT_SNTYPE>
            </SEGMENT_LOOP>
            </PRIMARY_KEY>
        proc
            if (_<structureName>Repo.Delete(<PRIMARY_KEY><SEGMENT_LOOP>a<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>) == RepositoryResult.NotFound)
                mreturn Request.CreateResponse(HttpStatusCode.NotFound)

            mreturn Request.CreateResponse(HttpStatusCode.NoContent)

        endmethod

    endclass

endnamespace