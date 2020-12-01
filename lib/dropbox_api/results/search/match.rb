module DropboxApi::Results::Search
  class Match
    def initialize(data)
      @data = data
    end

    def match_type
      @data["match_type"]
    end

    def resource
      @resource ||= DropboxApi::Metadata::Resource.new @data.dig("metadata", "metadata")
    end
  end
end
