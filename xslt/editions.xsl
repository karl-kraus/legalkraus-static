<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="partials/osd-container.xsl"/>
    <xsl:import href="partials/tei-facsimile.xsl"/>
    <xsl:import href="partials/shared.xsl"/>
    <xsl:import href="partials/aot-options.xsl"/>

    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="data(tei:TEI/@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:title[@type='label'][1]/text()"/>
    </xsl:variable>
    <xsl:variable name="colId">
        <xsl:value-of select="tokenize(data(/tei:TEI/tei:teiHeader/tei:fileDesc/tei:seriesStmt/tei:title/@ref), '/')[last()]"/>
    </xsl:variable>
    <xsl:variable name="colTitle">
        <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:seriesStmt/tei:title/text()"/>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='main'][1]/text()"/>
        </xsl:variable>
        
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="p-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="toc.html">Akten</a></li>
                            <li class="breadcrumb-item"><a><xsl:attribute name="href"><xsl:value-of select="concat($colId, '.html')"/></xsl:attribute><xsl:value-of select="$colTitle"/></a></li>
                            <li class="breadcrumb-item active" aria-current="page"><xsl:value-of select="$doc_title"/></li>
                        </ol>
                    </nav>
                    
                    <div class="container-fluid">                        
                        <div class="wp-transcript">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-2 col-lg-2 col-sm-12">
                                        <xsl:if test="ends-with($prev,'.html')">
                                            <h1>
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:value-of select="$prev"/>
                                                    </xsl:attribute>
                                                    <i class="fas fa-chevron-left" title="prev"/>
                                                </a>
                                            </h1>
                                        </xsl:if>
                                    </div>
                                    <div class="col-md-8 col-lg-8 col-sm-12">
                                        <h1 align="center">
                                            <xsl:value-of select="$doc_title"/>
                                        </h1>
                                        <h3 align="center">
                                            <a href="{$teiSource}">
                                                <i class="fas fa-download" title="show TEI source"/>
                                            </a>
                                        </h3>
                                    </div>
                                    <div class="col-md-2 col-lg-2 col-sm-12" style="text-align:right">
                                        <xsl:if test="ends-with($next, '.html')">
                                            <h1>
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:value-of select="$next"/>
                                                    </xsl:attribute>
                                                    <i class="fas fa-chevron-right" title="next"/>
                                                </a>
                                            </h1>
                                        </xsl:if>
                                    </div>
                                </div>
                                <div id="editor-widget">
                                    <p>Text Editor</p>
                                    <xsl:call-template name="annotation-options"></xsl:call-template>
                                </div>
                            </div>
                            <div id="container-resize" class="row transcript active">
                                <div id="img-resize" class="col-md-6 col-lg-6 col-sm-12 facsimiles">
                                    <div id="viewer">
                                        <div id="container_facs_1">
                                            <!-- container and facs handling in js -->
                                        </div>
                                    </div>
                                </div>
                                <div id="text-resize" class="col-md-6 col-lg-6 col-sm-12 text yes-index">
                                    <div id="section">
                                        
                                            <div class="card-body">
                                                <xsl:apply-templates select="//tei:body"></xsl:apply-templates>
                                            </div>
                                            <xsl:if test="//tei:note[@type='footnote']">
                                                <div class="card-footer">
                                                    <a class="anchor" id="footnotes"></a>
                                                    <ul class="footnotes">
                                                        <xsl:for-each select="//tei:note[@place='foot']">
                                                            <li>
                                                                <a class="anchorFoot" id="{@xml:id}"></a>
                                                                <span class="footnote_link">
                                                                    <a href="#{@xml:id}_inline" class="nounderline">
                                                                        <xsl:value-of select="@n"/>
                                                                    </a>
                                                                </span>
                                                                <span class="footnote_text">
                                                                    <xsl:apply-templates/>
                                                                </span>
                                                            </li>
                                                        </xsl:for-each>
                                                    </ul>
                                                </div>
                                            </xsl:if>
                                        
                                    </div>
                                </div>
                            </div>
                            <!-- create list* elements for entities bs-modal -->
                            <xsl:for-each select="//tei:back">
                                <div class="tei-back">
                                    <xsl:apply-templates/>
                                </div>
                            </xsl:for-each>
                        </div>                       
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
                <script src="https://unpkg.com/de-micro-editor@0.2.6/dist/de-editor.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.0.0/openseadragon.min.js"></script>
                <script type="text/javascript" src="js/osd_scroll.js"></script>
                <script type="text/javascript" src="js/run.js"></script>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:note">
        <xsl:choose>
            <xsl:when test="@place='foot'">
                <a class="anchorFoot" id="{@xml:id}_inline"></a>
                <a href="#{@xml:id}" title="Fußnote {@n}" class="nounderline">
                    <sup><xsl:value-of select="@n"/></sup>
                </a>
            </xsl:when>
            <xsl:when test="@place='end'">
                <a class="anchorFoot" id="{@xml:id}_inline"></a>
                <a href="#{@xml:id}" title="Fußnote {@n}" class="nounderline">
                    <sup><xsl:value-of select="@n"/></sup>
                </a>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:pb">
        <xsl:variable name="pbId">
            <xsl:value-of select="replace(data(@facs), '#', '')"/>
        </xsl:variable>
        <xsl:variable name="surfaceNode" as="node()">
            <xsl:value-of select="//tei:graphic[@xml:id=$pbId]"/>
        </xsl:variable>
        <xsl:variable name="facsUrl">
            <xsl:value-of select="data(//tei:surface[@xml:id=$pbId]/tei:graphic/@url)"/>
        </xsl:variable>
        
        <span class="anchor-pb"></span>
        <span class="pb" source="{$facsUrl}"><xsl:value-of select="./@n"/></span>
    </xsl:template>
</xsl:stylesheet>