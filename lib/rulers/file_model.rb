require "json"

module Rulers
  module Model
    class FileModel
      def initialize(filename)
        @filename = filename

        basename = File.split(filename)[-1]
        @id = File.basename(basename, ".json").to_i

        obj = File.read(filename)
        @hash = JSON.parse(obj)
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

      def save
        json_data = JSON.dump(
          {
            submitter: attrs[:submitter],
            quote: attrs[:quote],
            attribution: attrs[:attribution]
          }
        )

        File.write(@filename, json_data)
      end

      def self.create(**attrs)
        id = Dir["db/quotes/*.json"].map { File.split(_1)[-1].to_i }.max + 1

        json_data = JSON.dump(
          {
            submitter: attrs[:submitter] || "",
            quote: attrs[:quote] || "",
            attribution: attrs[:attribution] || ""
          }
        )
        File.write("db/quotes/#{id}.json", json_data)

        FileModel.new "db/quotes/#{id}.json"
      end

      def self.all
        Dir["db/quotes/*.json"].map { FileModel.new _1 }
      end

      def self.find(id)
        FileModel.new("db/quotes/#{id}.json")
      rescue Errno::ENOENT
        nil
      end
    end
  end
end
