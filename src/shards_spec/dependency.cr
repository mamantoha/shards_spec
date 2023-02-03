module ShardsSpec
  class Dependency
    property name : String
    property params : Hash(String, String) = Hash(String, String).new

    delegate :[], :keys, :fetch, to: params

    def initialize(@name : String)
    end

    def initialize(@name : String, config)
      config.each { |k, v| params[k.to_s] = v.to_s }
    end

    def self.new(pull : YAML::PullParser)
      name = pull.read_scalar

      params = Hash(String, String).new

      pull.read_mapping do
        until pull.kind.mapping_end?
          key, value = pull.read_scalar, pull.read_scalar

          params[key] = value
        end
      end

      Dependency.new(name, params)
    end

    def version
      version { "*" }
    end

    def version?
      version { nil }
    end

    def prerelease?
      Versions.prerelease? version
    end

    private def version(&)
      if version = params["version"]?
        version
      elsif params["tag"]? =~ VERSION_TAG
        $1
      else
        yield
      end
    end

    def refs
      params["branch"]? || params["tag"]? || params["commit"]?
    end

    def path
      params["path"]?
    end

    def to_human_requirement
      if version = version?
        version
      elsif branch = params["branch"]?
        "branch #{branch}"
      elsif tag = params["tag"]?
        "tag #{tag}"
      elsif commit = params["commit"]?
        "commit #{commit}"
      else
        "*"
      end
    end

    def to_s(io)
      io << name << " " << version
    end

    def inspect(io)
      io << "#<" << self.class.name << " {" << name << " => "
      super
      io << "}>"
    end
  end
end
