module Rsm
  module Actions
    TAR_OPTS = {:gz => '-z', :bz2 => '-j'}.freeze

    # relative downloaded filename
    # *name*:: application name
    # *compressor*:: +:gz+ or +:bz2+
    def downloaded_file(name, compressor)
      "#{name}.tar.#{compressor}"
    end

    # download archive form +uri+ and temporary save it
    # *name*:: application name
    # *uri*:: source URI - supported by +open-uri+.
    # *compressor*:: +:gz+ or +:bz2+
    def fetch_temporary_archive(name, uri, compressor)
      get uri, downloaded_file(name, compressor)
    end

    # unpack temporary archive file
    # *name*:: application name
    # *compressor*:: +:gz+ or +:bz2+
    def unpack_compressed_archive(name, compressor)
      opt = TAR_OPTS[compressor]
      run "tar --remove-files #{opt} -xf #{downloaded_file(name, compressor)}"
    end
  end
end
