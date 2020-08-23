class Spc < Formula
  version "v0.5"
  desc "A spotify daemon"
  homepage "https://github.com/dvdmuckle/spc"

  bottle :unneeded

  if OS.mac?
    url "https://github.com/dvdmuckle/spc/releases/download/v#{version}/spc_v#{version}_darwin_amd64.tar.gz"
    sha256 "a859e8e105bf47b1b9e8157aaef25887dc9c0b8ac77c3128a05020e9f7f45f96"
  elsif OS.linux?
    url "https://github.com/dvdmuckle/spc/releases/download/v#{version}/spc_v#{version}_linux_amd64.tar.gz"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
end

  def install
    bin.install "spc"

    output = Utils.safe_popen_read({ "SHELL" => "bash" }, bin/"spc", "completion", "bash")
    (bash_completion/"spc").write output

    output = Utils.safe_popen_read({ "SHELL" => "zsh" }, bin/"spc", "completion", "zsh")
    (zsh_completion/"_spc").write output

end

end
