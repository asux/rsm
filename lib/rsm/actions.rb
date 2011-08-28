module Rsm
  module Actions
    # relative downloaded filename
    def downloaded_file(compressor)
      "#{name}.tar.#{compressor}"
    end

    # download archive form +uri+ and temporary save it
    # *compressor*:: +:gz+ or +:bz2+
    def fetch_temporary_archive(uri, compressor)
      get uri, downloaded_file(compressor)
    end

    # unpack temporary archive file
    # *compressor*:: +:gz+ or +:bz2+
    def unpack_compressed_archive(compressor)
      tar_opts = {:gz => '-z', :bz2 => '-j'}
      opt = tar_opts[compressor]
      inside destination_root do
        run "tar #{opt} -xf #{downloaded_file(compressor)}"
        remove_file downloaded_file(compressor)
      end
    end
  end
end