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
            <xsl:value-of select="head(.//tei:title)/text()"/>
        </xsl:variable>
        <xsl:variable name="caseId">
            <xsl:value-of select="replace(replace(data(/tei:TEI/@xml:id), 'C_', 'D_'), '.xml', '-')"/>
        </xsl:variable>
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"/>
                </xsl:call-template>
            </head>

            <body class="page">
                <div class="hfeed site d-flex flex-column min-vh-100" id="page">
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
                        <div>
                          <a class="btn btn-primary text-white d-block mt-3" data-bs-toggle="collapse" href="#collapseAbstract" role="button" aria-expanded="false" aria-controls="collapseAbstract">
                            <xsl:value-of select="count(collection(concat('../data/editions?select=', $caseId, '*.xml'))//tei:TEI)||' Dokumente: Zusammenfassung'"/>
                          </a>
                          <div class="collapse" id="collapseAbstract">
                            <xsl:apply-templates select="//tei:abstract"></xsl:apply-templates>
                          </div>
                        </div>
                        <div class="text-center mt-4">
                        <h2 class="text-center">Schlagworte</h2>
                        <xsl:for-each select="//tei:profileDesc/tei:textClass/tei:keywords/tei:term">
                            <span class="badge bg-secondary m-1"><xsl:value-of select="./text()"/></span>
                        </xsl:for-each></div>
                        <xsl:if test="count(//tei:particDesc/tei:listPerson/tei:person[ends-with(data(@role), 'ANG') or ends-with(data(@role), 'ANV')]) > 0 or count(//tei:particDesc/tei:listPerson/tei:person[ends-with(data(@role), 'ANG') or ends-with(data(@role), 'ANV')]) > 0">
                          <div class="row">
                              <h2 class="text-center mt-4">Gerichtsparteien</h2>
                              <div class="col-6 text-center">
                                  <h3>Kläger</h3>
                              <xsl:for-each select="//tei:particDesc/tei:listPerson/tei:person[ends-with(data(@role), 'ANK') or ends-with(data(@role), 'AKV')]">
                                  <span class="badge rounded-pill bg-dark-gray"><xsl:value-of select="./tei:persName/text()"/></span>
                              </xsl:for-each>
                              </div>
                              <div class="col-6 text-center">
                                  <h3>Beklagte</h3>
                                  <xsl:for-each select="//tei:particDesc/tei:listPerson/tei:person[ends-with(data(@role), 'ANG') or ends-with(data(@role), 'ANV')]">
                                      <span class="badge rounded-pill bg-light-blue"><xsl:value-of select="./tei:persName/text()"/></span>
                                  </xsl:for-each>
                              </div>
                          </div>
                        </xsl:if>
                        <div class="row mt-3">
                            <xsl:for-each select="collection(concat('../data/editions?select=', $caseId, '*.xml'))//tei:TEI">
                                <xsl:sort select="document-uri(/)"></xsl:sort>
                                <xsl:variable name="fullPath">
                                    <xsl:value-of select="tokenize(replace(document-uri(/), '.xml', '.html'), '/')[last()]"/>
                                </xsl:variable>
                                <xsl:variable name="fileName">
                                    <xsl:value-of select=".//tei:titleStmt/tei:title[1]/text()"/>
                                </xsl:variable>
                                <xsl:variable name="facsUrl">
                                    <xsl:value-of select="replace(data(.//tei:graphic[1]/@url)[1], '/full/full/', '/full/250,/')"/>
                                </xsl:variable>
                                <xsl:variable name="creationDate">
                                    <xsl:value-of select=".//tei:profileDesc/tei:creation"/>
                                </xsl:variable>

                                
                               
                                <div class="card case-card mb-4 shadow-0 bg-lighter-gray mx-auto border-0 rounded-0">
                                    <div class="row g-0 h-90">
                                        <div class="col-5 align-self-center">
                                            <img class="img-fluid rounded-0 mw-100" loading="lazy" alt="kein Bild" >
                                                <xsl:attribute name="src"><xsl:value-of select="$facsUrl"/></xsl:attribute>
                                            </img>
                                        </div>
                                        <div class="col-7 align-self-center h-100 overflow-auto pt-3">
                                            <div class="card-body">
                                                <p class="card-title fw-bold border-bottom border-primary border-5 pb-2">
                                                    <a href="{$fullPath}">
                                                        <xsl:value-of select="$fileName"/>
                                                    </a>
                                                </p>
                                                <p class="card-text"><xsl:value-of select="$creationDate"/></p>
                                                <h6 class="card-title fw-bold">Orte</h6>
                                                <xsl:choose>
                                                    <xsl:when test=".//tei:listPlace">
                                                        <ul class="list-unstyled">
                                                            <xsl:for-each select=".//tei:listPlace/tei:place">
                                                                <li><xsl:value-of select="./tei:placeName[1]/text()"/></li>
                                                            </xsl:for-each>
                                                        </ul>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <p class="text-muted">keine Orte</p>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                                <h6 class="card-title fw-bold">Aktenklassifkiation</h6>
                                                <xsl:choose>
                                                    <xsl:when test=".//tei:listPlace">
                                                        <ul class="list-unstyled">
                                                            <xsl:for-each select="/tei:TEI/tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords/tei:term">
                                                                <li><xsl:value-of select="./text()"/></li>
                                                            </xsl:for-each>
                                                        </ul>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <p class="text-muted">keine Klassifikation</p>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                                <h6 class="card-title fw-bold">Materialität</h6>
                                                <xsl:choose>
                                                    <xsl:when test="//tei:listPlace">
                                                        <ul class="list-unstyled">
                                                            <xsl:for-each select="//tei:objectType">
                                                                <li><xsl:value-of select="./text()"/></li>
                                                            </xsl:for-each>
                                                        </ul>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <p class="text-muted">keine Angaben</p>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </xsl:for-each>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>


    <xsl:template match="tei:listBibl">
        <ul class="list-unstyled">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="tei:bibl">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ul class="list-unstyled">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="tei:item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="tei:ref[@target]">
        <a>
            <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
            <xsl:value-of select="./text()"/>
        </a>
    </xsl:template>

    <xsl:template match="tei:div/tei:head">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

    <xsl:template match="tei:p">
        <p id="{generate-id()}" class="mb-0 pt-3">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:div">
        <div id="{generate-id()}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:unclear">
        <abbr title="unclear">
            <xsl:apply-templates/>
        </abbr>
    </xsl:template>
    <xsl:template match="tei:del">
        <del>
            <xsl:apply-templates/>
        </del>
    </xsl:template>
    
    <xsl:template match="tei:table">
        <table><xsl:apply-templates/></table>
    </xsl:template>
    
    <xsl:template match="tei:row">
        <tr><xsl:apply-templates/></tr>
    </xsl:template>
    
    <xsl:template match="tei:cell">
        <td><xsl:apply-templates/></td>
    </xsl:template>
</xsl:stylesheet>
