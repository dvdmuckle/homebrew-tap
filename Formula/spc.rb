class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/1.1.5.tar.gz"
  sha256 "a9f64827d0aea58fcf52b6d4738d21acc5fb0dca2a956471756784420058d980"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, monterey:     "dc1b1012c2d632fa5fc048e2613969b8b9e659dc4838056cfcbd110522b32e6c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c139c324ba32b6f9c3daede404d18391c917ae0a42d14f81abb56d57c2d8c6b6"
  end
  depends_on "go" => :build

  def install
    system "go", "build", "-o", "spc", "-ldflags", "-X github.com/dvdmuckle/spc/cmd.version=#{version}"
    bin.install "spc"

    generate_completions_from_executable(bin/"spc", "completion")

    system bin/"spc", "docs", "man", "man1"
    man.install "man1"
  end
end
