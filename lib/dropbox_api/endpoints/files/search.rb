module DropboxApi::Endpoints::Files
  class Search < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = "/2/files/search_v2".freeze
    ResultType  = DropboxApi::Results::SearchResult
    ErrorType   = DropboxApi::Errors::SearchError

    include DropboxApi::OptionsValidator

    # Searches for files and folders.
    #
    # Note: Recent changes may not immediately be reflected in search results
    # due to a short delay in indexing.
    #
    # @param query [String] The string to search for. The search string is
    #   split on spaces into multiple tokens. For file name searching, the last
    #   token is used for prefix matching (i.e. "bat c" matches "bat cave" but
    #   not "batman car").
    # @option options path [String] The path in the user's Dropbox to search. 
    #   Searches the entire Dropbox if not specified.
    # @option options max_results [Numeric] The maximum number of search
    #   results to return. The default for this field is 100.
    # @option options order_by [open union] Specified property of the order of 
    #   search results. By default, results are sorted by relevance.
    # @option options file_status [open union] Restricts search to the given 
    #   file status. The default for this union is active.
    # @option options filename_only [Boolean] Restricts search to only match on 
    #   filenames. The default for this field is False.
    # @option options file_extensions [List of String] Restricts search to only 
    #    the extensions specified.
    # @option options file_categories [List of FileCategory] Restricts search to 
    #   only the file categories specified.

    add_endpoint :search_v2 do |query, options = {}, match_field_options = {}|  

      validate_options([
        :path,
        :max_results,
        :order_by,
        :file_status,
        :filename_only,
        :file_extensions,
        :file_categories,
      ], options)

      validate_options([
        :include_highlights
      ], match_field_options)

      request_params = { 
        query: query, 
        options: options, 
        match_field_options: match_field_options 
      }          
      perform_request(request_params)
    end
  end
end
