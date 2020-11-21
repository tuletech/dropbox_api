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

    add_endpoint :search do |query, options = {}|
      
      validate_options([
        :path,
        :max_results,
        :order_by,
        :file_status,
        :filename_only,
        :file_categories,
        :file_extension
      ], options)

      request_params = { query: query, options: options }          
      perform_request(request_params)
    end
  end
end
