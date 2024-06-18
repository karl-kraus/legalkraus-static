<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/legal.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select="'Juristische Texte'"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
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
                        <div class="card rounded-0">
                            <div class="card-header rounded-0 bg-darker-gray">
                                <h1><xsl:value-of select="$doc_title"/></h1>
                            </div>
                            <div class="card-body">                                
                                <table class="table table-striped display" id="tocTable" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Titel</th>
                                            <th scope="col">Gesetz</th>
                                            <th scope="col">Datum</th>
                                            <th scope="col">Erwähnungen</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select=".//tei:bibl">
                                            <xsl:variable name="id">
                                                <xsl:value-of select="data(@xml:id)"/>
                                            </xsl:variable>
                                            <tr>
                                                <td>
                                                    <a href="{concat($id, '.html')}">
                                                    <xsl:value-of select=".//tei:title[1]/text()"/>
                                                    </a>
                                                </td>
                                                <td><xsl:value-of select="./tei:title[@level='s']"/></td>
                                                <td>
                                                    <xsl:value-of select=".//tei:date[1]/text()"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="count(./tei:ref)"/>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                            </div>
                        </div>                       
                    </div>
                    <xsl:call-template name="html_footer"/>
                    <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.11.0/b-2.0.0/b-html5-2.0.0/cr-1.5.4/r-2.2.9/sp-1.4.0/datatables.min.js"></script>
                    <script type="text/javascript" src="js/dt.js"></script>
                    <script>
                        $(document).ready(function () {
                        createDataTable('tocTable');
                        });
                    </script>
                </div>
            </body>
        </html>
        <xsl:for-each select=".//tei:bibl">
            <xsl:variable name="filename" select="concat(./@xml:id, '.html')"/>
            <xsl:variable name="name" select="./tei:title[1]/text()"></xsl:variable>
            <xsl:result-document href="{$filename}">
                <html xmlns="http://www.w3.org/1999/xhtml">
                    <xsl:call-template name="html_head">
                        <xsl:with-param name="html_title" select="$name"></xsl:with-param>
                    </xsl:call-template>
                    
                    <body class="page">
                        <div class="hfeed site d-flex flex-column min-vh-100" id="page">
                            <xsl:call-template name="nav_bar"/>
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="p-3">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                                    <li class="breadcrumb-item" aria-current="page"><a href="listlegal.html"><xsl:value-of select="$doc_title"/></a></li>
                                    <li class="breadcrumb-item active" aria-current="page"><xsl:value-of select="$name"/></li>
                                </ol>
                            </nav>
                            
                            <div class="container">                        
                                <div class="card rounded-0">
                                    <div class="card-header rounded-0 bg-darker-gray">
                                        <h1>
                                            <xsl:value-of select="$name"/>
                                            <a class="ps-2" title="zur Online Ausgabe von {$name}" href="{./@corresp}"><i class="fas fa-external-link-alt fa-sm"></i></a>
                                        </h1>
                                    </div>
                                    <div class="card-body">
                                        <xsl:call-template name="legal_detail"/>
                                        <div>
                                            <h3>erwähnt in</h3>
                                            <ul>
                                                <xsl:for-each select="./tei:ref[@target]">
                                                    <li>
                                                        <a href="{replace(@target, '.xml', '.html')}">
                                                            <xsl:value-of select="."/>
                                                        </a>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <xsl:call-template name="html_footer"/>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
            
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>