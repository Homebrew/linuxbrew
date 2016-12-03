class SquirrelSql < Formula
  desc "GUI for JDBC-compliant databases"
  homepage "http://www.squirrelsql.org/"
  head "git://git.code.sf.net/p/squirrel-sql/git"

  depends_on "ant" => :build
  depends_on :java

  def install
    cd "sql12" do
      system "ant"
      cd buildpath/"sql12/output/plainZip" do 
        zipfile = Dir.glob("squirrelsql-snapshot-*_*-standard.zip")[0]
        system "unzip", zipfile
        unzipped = zipfile[0 ... -4] # trim off the ".zip"
        cd unzipped do
          # install the libraries
          lib.install Dir["lib/*.jar"]
          
          # fix home location
          inreplace "squirrel-sql.sh", "SQUIRREL_SQL_HOME=`dirname \"$0\"`", "SQUIRREL_SQL_HOME=#{prefix}"
          
          # install the shell script
          bin.install "squirrel-sql.sh"
          bin.install_symlink "squirrel-sql.sh" => "squirrel-sql"
          
          # install the JAR
          lib.install "squirrel-sql.jar"
        end
      end
    end
  end
        
  def caveats
    <<-EOS.undent
    The plugins have not been installed because I'm lazy.
    EOS
  end

  test do
    system "false"
  end
end
