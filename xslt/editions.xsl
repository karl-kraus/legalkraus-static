<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:utils="http://example.com/utils" version="2.0"
    exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"
        omit-xml-declaration="yes"/>

    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="partials/osd-container.xsl"/>
    <xsl:import href="partials/tei-facsimile.xsl"/>
    <xsl:import href="partials/shared.xsl"/>
    <xsl:import href="partials/aot-options.xsl"/>
    <xsl:import href="utils.xsl"/>

    <xsl:variable name="teiHeader" select="//tei:teiHeader"/>
    <xsl:variable name="facs" select="//tei:facsimile"/>

    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"
        />
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"
        />
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="data(tei:TEI/@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:title[@type = 'label'][1]/text()"/>
    </xsl:variable>
    <xsl:variable name="colId">
        <xsl:value-of
            select="tokenize(data(/tei:TEI/tei:teiHeader/tei:fileDesc/tei:seriesStmt/tei:title/@ref), '/')[last()]"
        />
    </xsl:variable>
    <xsl:variable name="colTitle">
        <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:seriesStmt/tei:title/text()"/>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select="head(.//tei:title)/text()"/>
        </xsl:variable>

        <html lang="de">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"/>
                    <xsl:with-param name="include_datatableslib" select="false()"/>
                </xsl:call-template>
            </head>
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="p-3 pb-0">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="toc.html">Akten</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="concat($colId, '.html')"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$colTitle"/>
                                </a>
                            </li>
                            <li class="breadcrumb-item active text-truncate" aria-current="page">
                                <xsl:value-of select="$doc_title"/>
                            </li>
                        </ol>
                    </nav>

                    <div id="content" class="container-fluid w-xl-90 p-3">
                        <div class="wp-transcript">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-2 d-none d-md-block">
                                        <xsl:if test="ends-with($prev, '.html')">
                                                <a>
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of select="$prev"/>
                                                  </xsl:attribute>
                                                  <i class="fas fa-chevron-left" title="prev"/>
                                                </a>
                                        </xsl:if>
                                    </div>
                                    <div class="col-md-8 col-lg-8 col-sm-12">
                                        <div class="row">
                                            <div class="col">
                                                <h1 align="center">
                                                  <xsl:value-of select="$doc_title"/>
                                                </h1>
                                            </div>
                                        </div>
                                        <div class="row py-3">
                                            <div class="col-12" id="reader" data-page="1">
                                                <div
                                                  class="d-flex justify-content-center align-items-center gap-3 mb-3">
                                                  <div>
                                                  <a href="{$teiSource}">
                                                  <i class="fas fa-download fa-lg"
                                                  title="show TEI source"/>
                                                  </a>
                                                  </div>
                                                  <div class="ms-2">
                                                  <span>
                                                  <span>
                                                  <button id="prevPage" onclick="Pager.selectPage('prev')" class="me-1 bg-white border-0 align-middle">
                                                  <i class="fas fa-arrow-left fa-lg"
                                                  title="go to previous page"/>
                                                  </button></span>
                                                  <xsl:text>Seite </xsl:text>
                                                  <xsl:variable name="select_enabled">
                                                  <xsl:value-of
                                                  select="count(//tei:pb) > 1 or (not(//tei:pb) and count(//tei:graphic[@source = 'wienbibliothek']) > 1)"
                                                  />
                                                  </xsl:variable>
                                                  <select id="page-selector" onchange="Pager.selectPage()"
                                                  class="form-select form-select-sm w-auto ml-2 d-inline"
                                                  aria-label="page selector">
                                                  <xsl:if test="$select_enabled = false()">
                                                  <xsl:attribute name="disabled"/>
                                                  </xsl:if>

                                                  <xsl:for-each select="//tei:pb">
                                                  <xsl:apply-templates select="current()"
                                                  mode="page-selector"/>
                                                  <xsl:variable name="page_nr"
                                                  select="count(preceding::tei:pb) + 1"/>
                                                  </xsl:for-each>
                                                  <xsl:if test="count(//tei:pb) = 0">
                                                  <xsl:for-each
                                                  select="//tei:graphic[@source = 'wienbibliothek']">
                                                  <option value="{current()/@url}">
                                                  <xsl:value-of
                                                  select="count(current()/preceding::tei:graphic[@source = 'wienbibliothek']) + 1"
                                                  />
                                                  </option>
                                                  </xsl:for-each>
                                                  </xsl:if>
                                                  </select>
                                                  <xsl:text> von </xsl:text>
                                                  <xsl:value-of select="
                                                                    if (//tei:pb) then
                                                                        count(//tei:pb)
                                                                    else
                                                                        count(//tei:graphic[@source = 'wienbibliothek'])"
                                                  />
                                                  <button id="nextPage" onclick="Pager.selectPage('next')" class="ms-1 bg-white border-0 align-middle">
                                                  <i class="fas fa-arrow-right fa-lg"
                                                  title="go to next page"/>
                                                  </button>
                                                  </span>
                                                  </div>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                              <div class="d-flex justify-content-center gap-2">
                                                <full-size opt="fls"></full-size>
                                                <image-switch opt="es"></image-switch>
                                              </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 d-none d-md-block"
                                        style="text-align:right">
                                        <xsl:if test="ends-with($next, '.html')">
                                                <a>
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of select="$next"/>
                                                  </xsl:attribute>
                                                  <i class="fas fa-chevron-right" title="next"/>
                                                </a>
                                        </xsl:if>
                                    </div>
                                </div>
                                <div class="row justify-content-between">
                                    <!--<div class="col-12">
                                    
                                  </div>-->
                                </div>
                            </div>
                            <div id="container-resize" class="row transcript active">
                                <div id="img-resize" class="col-md-6 bg-white-gray facsimiles">
                                    
                                      <div id="viewer">
                                          <div id="container_facs_1">
                                              <!-- container and facs handling in js -->
                                          </div>
                                      </div>
                                </div>
                                <div id="text-resize"
                                    class="col-md-6 col-lg-6 col-sm-12 text yes-index">
                                    <div id="section" class="bg-white-gray overflow-auto">
                                      <div id="editor-widget">
                                        <xsl:call-template name="annotation-options"/>
                                      </div>
                                      <div id="doc-wrapper" class="p-5 overflow-auto">
                                            <!--<xsl:apply-templates select="//tei:body"></xsl:apply-templates>-->
                                            <xsl:choose>
                                                <xsl:when test="//tei:pb">
                                                  <xsl:for-each select="//tei:pb">
                                                  <xsl:variable name="facs">
                                                  <xsl:value-of select="current()/@facs"/>
                                                  </xsl:variable>
                                                  <xsl:apply-templates select="current()"/>
                                                  <xsl:variable name="nextPb"
                                                  select="current()/following::tei:pb[1]"/>
                                                  <div class="{if (count(preceding::tei:pb) = 0) then 'd-block' else 'd-none'} position-relative" id="page_{count(preceding::tei:pb) + 1}">
                                                  <xsl:choose>
                                                  <xsl:when test="$nextPb">
                                                  <xsl:apply-templates
                                                  select="utils:split(current(), $nextPb, //tei:TEI)"
                                                  />
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:apply-templates
                                                  select="utils:split(current(), (//tei:TEI//element())[last()], //tei:TEI)"
                                                  />
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                  </div>
                                                  </xsl:for-each>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of
                                                  select="//tei:body//tei:div[@type = 'no-transcription']"
                                                  />
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        <xsl:if test="//tei:note[@type = 'footnote']">
                                            <div class="card-footer">
                                                <a class="anchor" id="footnotes"/>
                                                <ul class="footnotes">
                                                  <xsl:for-each select="//tei:note[@place = 'foot']">
                                                  <li>
                                                  <a class="anchorFoot" id="{@xml:id}"/>
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
                            </div>
                            <!-- create list* elements for entities bs-modal -->
                            <xsl:for-each select="//tei:back">
                                <div class="tei-back">
                                    <xsl:apply-templates/>
                                </div>
                            </xsl:for-each>
                            <xsl:for-each select="//tei:rdg">
                              <xsl:variable name="witnessId" select="replace(current()/@wit,'#','')"/>
                              <div class="modal modal-xl" id="witnessModal{$witnessId}" tabindex="-1" role="dialog">
                                  <div class="modal-dialog" role="document">
                                      <div class="modal-content">
                                          <div class="modal-header">
                                              <h5 class="modal-title">Textzeuge</h5>
                                              <button type="button" class="btn-close"
                                                  aria-label="Close" data-bs-dismiss="modal"/>
                                          </div>
                                          <div class="modal-body text-center">
                                          <xsl:variable name="facsId" select="replace(//tei:witness[@xml:id = $witnessId]/@facs,'#','')"/>
                                          <xsl:variable name="imageSource">
                                            <xsl:value-of select="data(//tei:facsimile[@xml:id = $facsId]//@url)"/>
                                          </xsl:variable>
                                            <div>
                                              <img src="{replace($imageSource,'full/full','full/600,')}"/>
                                            </div>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                            </xsl:for-each>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer">
                        <xsl:with-param name="include_jquery" select="false()"/>                   
                    </xsl:call-template>
                </div>
                <div class="modal" id="nicht_erfasst" tabindex="-1" role="dialog">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content rounded-0">
                            <div class="modal-header rounded-0 bg-darker-gray">
                                <h5 class="modal-title">Nicht erfasst</h5>
                                <button type="button" class="btn-close"
                                    aria-label="Close" data-bs-dismiss="modal"/>
                            </div>
                        </div>
                    </div>
                </div>
                <script src="https://unpkg.com/de-micro-editor@0.2.6/dist/de-editor.min.js"/>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.0.0/openseadragon.min.js"/>
                <script type="text/javascript" src="js/osd_select.js"/>
                <script type="text/javascript" src="js/run.js"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:note">
        <xsl:choose>
            <xsl:when test="@place = 'foot'">
                <a class="anchorFoot" id="{@xml:id}_inline"/>
                <a href="#{@xml:id}" title="Fußnote {@n}" class="nounderline">
                    <sup>
                        <xsl:value-of select="@n"/>
                    </sup>
                </a>
            </xsl:when>
            <xsl:when test="@place = 'end'">
                <a class="anchorFoot" id="{@xml:id}_inline"/>
                <a href="#{@xml:id}" title="Fußnote {@n}" class="nounderline">
                    <sup>
                        <xsl:value-of select="@n"/>
                    </sup>
                </a>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:pb" mode="page-selector">
        <xsl:variable name="pbId">
            <xsl:value-of select="replace(data(@facs), '#', '')"/>
        </xsl:variable>
        <xsl:variable name="facs">
            <xsl:value-of select="@facs"/>
        </xsl:variable>
        <xsl:variable name="surfaceNode" as="node()">
            <xsl:value-of select="//tei:graphic[@xml:id = $pbId]"/>
        </xsl:variable>
        <xsl:variable name="facsUrl"
            select=".//root()//*[@xml:id = ($facs, substring-after(data($facs), '#'))]//tei:graphic[@source = 'wienbibliothek']/@url"/>
        <!--<span class="anchor-pb"></span>-->
        <option value="{$facsUrl}">
            <xsl:value-of select="@n"/>
        </option>
    </xsl:template>
    <!-- copied from old legalkraus app - adapted -->
    <xsl:template match="tei:note[@hand]">
        <span class="note-hand {@rend} {@type}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
<xsl:template match="tei:note[@type = 'intertext' and starts-with(@source, 'https://fackel')]">
        <span class="fackel-ref entity">
            <xsl:apply-templates/>
            <a href="{@source}" target="_blank" rel="noopener noreferrer" title="go to {@source}">
              <i class="fas fa-external-link-alt fa-sm"/>
            </a>
        </span>
    </xsl:template>
    <xsl:template match="tei:note[@type = 'marginal']">
        <span class="marginalie-text {@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:hi[@rend = 'underlined'][not(@hand)]">
        <span class="hi-underlined">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:hi[@rend = 'underlined'][@hand]">
        <span class="hi-hand-underlined">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:hi[@rend = 'spaced']">
        <span class="hi-spaced">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:add">
        <span class="add">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:add[@hand]">
        <span class="add-hand">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:del">
        <span class="del">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:del[@hand]">
        <span class="del-hand">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:subst">
        <span class="subst">
            <xsl:apply-templates/>
        </span>
    </xsl:template>



    <xsl:template match="tei:metamark[@function = 'marginal'][@hand][@rend]">
        <span class="metamark-no-text {@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:metamark[@function = 'transposition']">
        <xsl:variable name="target" select="@target"/>
        <xsl:variable name="ptrpos"
            select="$teiHeader//tei:transpose[@hand = ./@hand]//tei:ptr[@target = $target]/(count(preceding-sibling::tei:ptr) + 1)"/>
        <xsl:variable name="seg">
            <xsl:copy-of select="./root()//tei:seg[@type = 'transposition'][position() = $ptrpos]"/>
        </xsl:variable>
        <xsl:if test="not(preceding::*[2]/name() = 'metamark')">
            <xsl:value-of select="'{'"/>
        </xsl:if>
        <xsl:apply-templates select="$seg"/>
        <xsl:if test="not(following::*[2]/name() = 'metamark')">
            <xsl:value-of select="'}'"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:seg[@type = 'transposition']">
        <xsl:if test="not(ancestor::*[1])">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="tei:note[@type = 'paratext' and @resp = 'law-firm']">
        <span class="paratext">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:lb[not(@break)]">
        <span class="lb">
            <xsl:if test="(count(preceding::tei:lb) + 1) mod 5 = 0">
                <xsl:attribute name="data-linenr" select="count(preceding::tei:lb) + 1"/>
            </xsl:if>
        </span>
    </xsl:template>

    <xsl:template match="tei:lb[@break = 'no']">
        <span class="lb">
        <xsl:if test="(count(preceding::tei:lb) + 1) mod 5 = 0">
                <xsl:attribute name="data-linenr" select="count(preceding::tei:lb) + 1"/>
            </xsl:if>
        -</span>
    </xsl:template>
    <xsl:template match="tei:rdg">
        <xsl:variable name="witid" select="substring-after(@wit, '#')"/>
        <xsl:variable name="witfacsid">
            <xsl:value-of
                select="$teiHeader//tei:witness[@xml:id = $witid]/substring-after(@facs, '#')"/>
        </xsl:variable>
        <span class="rdg {if (tei:note[@rend='leftMargin']) then 'marginLeft' else ('mRight')}">
            <xsl:apply-templates/>
            <xsl:variable name="witnessfacs">
                <xsl:value-of
                    select="'[' || string-join($facs[@xml:id = $witfacsid]//tei:graphic[@source = 'wienbibliothek']/@url/('''' || string() || ''''), ',') || ']'"
                />
            </xsl:variable>
            <a id="show-btn" href="#" data-bs-toggle="modal" data-bs-target="#witnessModal{replace(@wit,'#','')}"
                class="d-block witness-link text-secondary">Textzeuge</a>
        </span>
    </xsl:template>
</xsl:stylesheet>