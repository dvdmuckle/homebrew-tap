class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/refs/tags/1.3.6.tar.gz"
  sha256 "754993f38365ae17f32c891f0615ad3b8946793157558774e3df825dd3c8e665"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "989f35f1343b7beee297ec3a2c563beef6f9ff507f363776f240912236f239c3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4a1b56c984b847b457464dc7ad59723e4b36af140efc78b6abeb7a8deafb6b55"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c1f608c8f906631d0a60fc15ec97c85a6f10baf6169cc51d79ec3360becf3842"
    sha256 cellar: :any,                 x86_64_linux:  "8cf5e00fd98284febd33f5465480f8e9a400b8ae3889cfa8094e069a5e080f34"
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
