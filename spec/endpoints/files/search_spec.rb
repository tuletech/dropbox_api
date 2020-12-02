describe DropboxApi::Client, "#search" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns a list of matching results", :cassette => "search/success" do
    result = @client.search("image.png")

    expect(result).to be_a(DropboxApi::Results::SearchResult)
    file = result.matches.first.resource
    expect(file.name).to eq("image.png")
  end

  it "does not raise an error if the file can't be found", :cassette => "search/not_found" do
    expect {
      @client.search("/image.png", { path: "/bad_folder" })
    }.not_to raise_error
  end

  it "returns empty matches if the file can't be found", :cassette => "search/not_found" do 
    result = @client.search("/image.png", { path: "/bad_folder" })
    
    expect(result).to be_a(DropboxApi::Results::SearchResult)
    expect(result.matches).to be_empty
  end
end
