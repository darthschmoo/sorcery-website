# hold off on building this for a while.  May be overkill.
require 'zip/zip'

module EpubForger
  class Assets
  end
  
  class MetaData
  end
  
  class Image
  end
  
  class Font
  end
  
  class Stylesheet
  end
  
  class Chapter
  end
  
  def initialize( &block )
    @creator = ""
    @title = ""
    @publisher = ""
    @date = Time.now.strftime("%Y-%m-%d")
    @stylesheets = []
    @fonts = []
    @images = []
    @canonical_url = ""
    yield self if block_given?
    
  end
  
  class Forge
    def save( filename )
      
    end
  end
  
  def container_xml
    xml = Builder::XmlMarkup.new(:indent => 2)
    xml.instruct!
    xml.container( :xmlns => "urn:oasis:names:tc:opendocument:xmlns:container", :version => "1.0") do
      xml.rootfiles do
        xml.rootfile( "full-path" => "OPS/package.opf", "media-type" => "application/oebps-package+xml")
      end
    end
    
    xml.target!  # returns text 
  end
  
  def package_opf
    xml = Builder::XmlMarkup.new(:indent => 2)
    xml.instruct!
    xml.package(xmlns: "http://www.idpf.org/2007/opf", version: "3.0", "xml:lang" => "en", "unique-identifier" => "pub-id") do
      xml.metadata("xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
        xml.dc(:title, id: "title")
    <<-EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <package xmlns="http://www.idpf.org/2007/opf" version="3.0" xml:lang="en" unique-identifier="pub-id">
      <!--I'm assuming prefixes for marc, onix, and xsd are predefined-->
      <metadata xmlns:dc="http://purl.org/dc/elements/1.1/">
        <dc:title id="title">Moby-Dick</dc:title>
        <meta refines="#title" property="title-type">main</meta>
        <dc:creator id="creator">Herman Melville</dc:creator>
        <meta refines="#creator" property="file-as">MELVILLE, HERMAN</meta>
        <meta refines="#creator" property="role" scheme="marc:relators">aut</meta>
        <dc:identifier id="pub-id">urn:isbn:9780316000000</dc:identifier>
        <meta refines="#pub-id" property="identifier-type" scheme="onix:codelist5">15</meta>
        <dc:language>en-US</dc:language>
        <meta property="dcterms:modified">2011-09-15T12:00:00Z</meta>
        <dc:publisher>Harper &amp; Brothers, Publishers</dc:publisher>
        <dc:contributor id="contrib1">Dave Cramer</dc:contributor>
        <meta refines="#contrib1" property="role" scheme="marc:relators">mrk</meta>
        <!--MEDIA OVERLAY METADATA-->
        <meta property="media:duration" refines="#chapter_001_overlay">0:14:43</meta>
        <meta property="media:duration" refines="#chapter_002_overlay">0:09:03</meta>
        <meta property="media:duration">0:23:46</meta>
        <meta property="media:narrator">Stuart Wills</meta>
        <meta property="media:active-class">-epub-media-overlay-active</meta>
      </metadata>
      <manifest>
        <item id="font.stix.regular" href="fonts/STIXGeneral.otf" media-type="application/vnd.ms-opentype"/>
        <item id="font.stix.italic" href="fonts/STIXGeneralItalic.otf" media-type="application/vnd.ms-opentype"/>
        <item id="font.stix.bold" href="fonts/STIXGeneralBol.otf" media-type="application/vnd.ms-opentype"/>
        <item id="font.stix.bold.italic" href="fonts/STIXGeneralBolIta.otf" media-type="application/vnd.ms-opentype"/>
        <item id="toc" properties="nav" href="toc.xhtml" media-type="application/xhtml+xml"/>
        <item id="copyright" href="copyright.xhtml" media-type="application/xhtml+xml"/>
        <item id="titlepage" href="titlepage.xhtml" media-type="application/xhtml+xml"/>
        <item id="cover" href="cover.xhtml" media-type="application/xhtml+xml"/>
        <item id="cover-image" properties="cover-image" href="images/9780316000000.jpg" media-type="image/jpeg"/>
        <item id="style" href="css/stylesheet.css" media-type="text/css"/>
        <item id="aMoby-Dick_FE_title_page" href="images/Moby-Dick_FE_title_page.jpg" media-type="image/jpeg"/>
        <item id="xpreface_001" href="preface_001.xhtml" media-type="application/xhtml+xml"/>
        <item id="xintroduction_001" href="introduction_001.xhtml" media-type="application/xhtml+xml"/>
        <item id="xepigraph_001" href="epigraph_001.xhtml" media-type="application/xhtml+xml"/>
        <item id="xchapter_001" href="chapter_001.xhtml" media-type="application/xhtml+xml" media-overlay="chapter_001_overlay"/>
        <item id="chapter_001_overlay" href="chapter_001_overlay.smil" media-type="application/smil+xml"/>
        <item id="xchapter_002" href="chapter_002.xhtml" media-type="application/xhtml+xml" media-overlay="chapter_002_overlay"/>
        <item id="chapter_002_overlay" href="chapter_002_overlay.smil" media-type="application/smil+xml"/>
        <item id="xchapter_003" href="chapter_003.xhtml" media-type="application/xhtml+xml"/>
        <item id="chapter_001_audio" href="audio/mobydick_001_002_melville.mp4" media-type="audio/mp4"/>
        <item id="xchapter_004" href="chapter_004.xhtml" media-type="application/xhtml+xml"/>
        <item id="xchapter_005" href="chapter_005.xhtml" media-type="application/xhtml+xml"/>
        <item id="xchapter_006" href="chapter_006.xhtml" media-type="application/xhtml+xml"/>
        <item id="xchapter_007" href="chapter_007.xhtml" media-type="application/xhtml+xml"/>
        <item id="xchapter_008" href="chapter_008.xhtml" media-type="application/xhtml+xml"/>
        ...
        <item id="xchapter_136" href="chapter_136.xhtml" media-type="application/xhtml+xml"/>
        <item id="brief-toc" href="toc-short.xhtml" media-type="application/xhtml+xml"/>
        <!-- 
        <item id="ncx" href="toc.ncx" media-type="application/x-dtbncx+xml"/>
     -->
      </manifest>
      <spine>
        <itemref idref="cover" linear="no"/>
        <itemref idref="titlepage" linear="yes"/>
        <itemref idref="brief-toc" linear="yes"/>
        <itemref linear="yes" idref="xpreface_001"/>
        <itemref linear="yes" idref="xintroduction_001"/>
        <itemref linear="yes" idref="xepigraph_001"/>
        <itemref linear="yes" idref="xchapter_001"/>
        <itemref linear="yes" idref="xchapter_002"/>
        <itemref linear="yes" idref="xchapter_003"/>
        ...
        <itemref linear="yes" idref="xchapter_136"/>
        <itemref idref="copyright" linear="yes"/>
        <itemref idref="toc" linear="no"/>
      </spine>
    </package>
    EOS
      end
    end
  end
end