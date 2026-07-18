class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/refs/tags/1.3.5.tar.gz"
  sha256 "a9ad19d538367ebfec3140a344dc83e05a50e0eb69ab40c6d9994cef606b803a"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b691a8b500c300be6030bf734fa3ab8b813991fcb2b9f82afc344547c785331e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "57e5ba5dd6af9c59d8b9cf4b32e220335b9c60ee434f8033642d976eda2f3024"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5cdacb332f64e511c4f7d1db5187ba7276110321d96fb82faeb19b4cc8e4342d"
    sha256 cellar: :any,                 x86_64_linux:  "266626c1501de6900685b27847c4e088d0fd334484a57b20ebede50dc6a402e9"
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
