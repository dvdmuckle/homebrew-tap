class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/refs/tags/1.3.1.tar.gz"
  sha256 "152ad3de58e86b4a59fa87a06a52417b359718740c460f24061175449cf054c8"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "57416fd6b70c5e787777d47100abb653277208551c5b692e9a0f86b1f9c3d627"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4e36a24be5148f52610f37b9cef84fc2cac8d231ca5b84d72eef0aeb81ca6199"
    sha256 cellar: :any_skip_relocation, ventura:       "0198d51bb13fed6f91e3c10e270effab3e75272638f83d69b01731b9ce5a3c76"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1ce6d5623c8eefed0abd32d8e576d1c240f32e3451e138646cb019e132d580db"
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
