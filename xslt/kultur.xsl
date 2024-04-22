<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="partials/osd-container.xsl"/>
    <xsl:import href="partials/tei-facsimile.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select="'Kultur'"/>
        </xsl:variable>
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"/>
                </xsl:call-template>
            </head>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="p-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page"><xsl:value-of select="$doc_title"/></li>
                        </ol>
                    </nav>
                    
                    <div class="container">
                      <h1 class="text-center">
                        <xsl:value-of select="$doc_title"/>
                      </h1>
                      <ul class="list-unstyled w-75 mx-auto m-5">
                          <li><a class="btn btn-primary text-white d-block" href="fackel-collections.html">Die Fackel</a></li>
                          <li class="pt-3"><a class="btn btn-primary text-white d-block" href="theater-collections.html">Theater</a></li>
                          <li class="pt-3"><a class="btn btn-primary text-white d-block" href="verlage-collections.html">Verlagswesen</a></li>
                          <li class="pt-3"><a class="btn btn-primary text-white d-block" href="medienhistorisches-collections.html">Medienhistorisches</a></li>
                          <li class="pt-3"><a class="btn btn-primary text-white d-block" href="berichtigung-collections.html">Berichtigung (Ausgang)</a></li>
                          <li class="pt-3"><a class="btn btn-primary text-white d-block" data-bs-toggle="collapse" href="#collapseLinks" role="button" aria-expanded="false" aria-controls="collapseExample">
                          Die großen Polemiken</a>
                              <ul class="list-unstyled collapse text-center" id="collapseLinks">
                                  <li class="pt-3"><a class="btn btn-lighter-gray" href="polemik-tagblatt.html">Berliner Tagblatt</a></li>
                                  <li class="pt-3"><a class="btn btn-lighter-gray" href="polemik-stunde.html">Die Stunde, Békessy</a></li>
                                  <li class="pt-3"><a class="btn btn-lighter-gray" href="polemik-schober.html">Schober, 15. Juli 1927</a></li>
                              </ul>
                          </li>
                      </ul>
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>
    

</xsl:stylesheet>
