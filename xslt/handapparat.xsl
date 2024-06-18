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
            <xsl:value-of select=".//tei:title[1]/text()"/>
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
                      
                        <xsl:apply-templates select=".//tei:body"/>
                        
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
        <h1 class="mb-3">
            <xsl:apply-templates/>
        </h1>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p id="{generate-id()}">
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
</xsl:stylesheet>
