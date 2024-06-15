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
    <xsl:import href="./partials/fackel.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:titleStmt/tei:title[1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
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
                                            <th scope="col">Datum</th>
                                            <th scope="col">Ausgabe</th>
                                            <th scope="col">Seite</th>
                                            <th scope="col">Erwähnungen</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select=".//tei:bibl[@xml:id]">
                                            <xsl:variable name="id">
                                                <xsl:value-of select="data(@xml:id)"/>
                                            </xsl:variable>
                                            <xsl:variable name="fackelTitel">
                                                <xsl:choose>
                                                    <xsl:when test="./tei:title[@level='a']">
                                                        <xsl:value-of select="./tei:title[@level='a']/text()"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="./tei:title[@level='s']/text()"/>, <xsl:value-of select="./string-join(.//tei:num, ', ')"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:variable>
                                            <tr>
                                                <td>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:value-of select="concat($id, '.html')"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="$fackelTitel"/>
                                                    </a> 
                                                </td>
                                                <td>
                                                    <xsl:value-of select="./tei:date[1]/@when-iso"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="./tei:num[@type='volume']/text()"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="./tei:biblScope/text()"/>
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
        <xsl:for-each select=".//tei:bibl[@xml:id]">
            <xsl:variable name="filename" select="concat(./@xml:id, '.html')"/>
           
            <xsl:variable name="name">
                <xsl:choose>
                    <xsl:when test="./tei:title[@level='a']">
                        <xsl:value-of select="./tei:title[@level='a']/text()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="./tei:title[@level='s']/text()"/>, <xsl:value-of select="./string-join(.//tei:num, ', ')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:result-document href="{$filename}">
                <html xmlns="http://www.w3.org/1999/xhtml">
                    <xsl:call-template name="html_head">
                        <xsl:with-param name="html_title" select="$name"></xsl:with-param>
                    </xsl:call-template>
                    
                    <body class="page">
                        <div class="hfeed site" id="page">
                            <xsl:call-template name="nav_bar"/>
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="p-3">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                                    <li class="breadcrumb-item" aria-current="page"><a href="listfackel.html"><xsl:value-of select="$doc_title"/></a></li>
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
                                        <xsl:call-template name="fackel_detail"/>  
                                       
                                            <p class="pt-2">
                                                <h3>erwähnt in</h3>
                                                    <ul>
                                                        <xsl:for-each select="./tei:ref">
                                                            <xsl:variable name="docTitle">
                                                                <xsl:value-of select="tokenize(./text(), '\|')[1]"/>
                                                            </xsl:variable>
                                                            <xsl:variable name="docId">
                                                                <xsl:value-of select="replace(tokenize(./text(), '\|')[2], '.xml', '.html')"/>
                                                            </xsl:variable>
                                                            <li>
                                                                <a href="{$docId}"><xsl:value-of select="$docTitle"/></a>
                                                            </li>
                                                        </xsl:for-each>
                                                    </ul>
                                            </p>
                                        
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