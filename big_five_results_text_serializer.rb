class BigFiveResultsTextSerializer
    attr_accessor :file_path

    def initialize (file_path)
        if !File.exists?(file_path) || !File.readable?(file_path) || !File.file?(file_path)
            raise "File doesn't seem to be readable at this path."
        end

        @file_path = file_path
    end

    def to_h
        results = { 'NAME' => 'Syed Aslam' }

        if File.zero?(file_path)
            raise "File doesn't have any content!"
        end

        File.open(@file_path).readlines.each do |line|
            scores = line.rstrip.split(',').each_slice(2).to_a
            domain = scores.shift
            results[domain.first] = { "Overall Score" => domain[1].to_i }

            results[domain.first]['Facets'] = Hash[scores.collect { |facet| [facet[0], facet[1].to_i] }]
        end

        results
    end
end
