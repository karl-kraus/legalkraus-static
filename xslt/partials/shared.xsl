<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:function name="local:makeId" as="xs:string">
        <xsl:param name="currentNode" as="node()"/>
        <xsl:variable name="nodeCurrNr">
            <xsl:value-of select="count($currentNode//preceding-sibling::*) + 1"/>
        </xsl:variable>
        <xsl:value-of select="concat(name($currentNode), '__', $nodeCurrNr)"/>
    </xsl:function>
    
    <!--<xsl:template match="tei:pb">
        <span class="anchor-pb"></span>
        <span class="pb" source="{@facs}"><br/></span>
    </xsl:template>-->
    <xsl:template match="tei:unclear">
        <abbr title="unclear"><xsl:apply-templates/></abbr>
    </xsl:template>
    <xsl:template match="tei:cit">
        <cite><xsl:apply-templates/></cite>
    </xsl:template>
    <xsl:template match="tei:quote">
        <xsl:choose>
          <xsl:when test="count(tokenize(@source, ' ')) > 1">
            <span class="quotes {substring-after(@rendition, '#')}" id="{@xml:id}">
                <xsl:apply-templates/>
                <xsl:for-each select="tokenize(@source, ' ')">
                    <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                        <xsl:value-of select="position()"/>
                    </sup>
                    <xsl:if test="position() != last()">
                        <sup class="entity">/</sup>
                    </xsl:if>
                </xsl:for-each>
            </span>
          </xsl:when>
          <xsl:when test="matches(@source,'#[0-9]+')">
            <span class="quotes entity {substring-after(@rendition, '#')} cursor-pointer" id="{@xml:id}" data-bs-toggle="modal" data-bs-target="{'#pmb'||replace(@source,'#','')}">
              <xsl:apply-templates/>
            </span>
          </xsl:when>
          <xsl:when test="starts-with(@source,'https://fackel')">
            <span class="quotes entity {substring-after(@rendition, '#')}" id="{@xml:id}">
              <xsl:apply-templates/>
               <a href="{@source}" target="_blank" class="align-text-bottom ps-1 link-ext d-none" rel="noopener noreferrer" title="go to {@source}">
                <i class="fas fa-external-link-alt fa-sm"/>
              </a>
            </span>
          </xsl:when>
          <xsl:when test="starts-with(@source,'https://id.acdh.oeaw.ac.at/legalkraus')">
            <xsl:variable name="doc_name" select="replace(tokenize(@source,'/')[last()],'.xml','')"/>
            <span class="quotes entity {substring-after(@rendition, '#')}" id="{@xml:id}">
                <xsl:apply-templates/>
                <a href="{$doc_name||'.html'}" target="_blank" class="align-text-bottom ps-1 link-ext d-none" rel="noopener noreferrer" title="go to {@ref}">
                  <i class="fas fa-external-link-alt fa-sm"/>
                </a>
            </span>
          </xsl:when>
          <xsl:when test="not(@source) or @source=''">
            <span class="quotes entity {substring-after(@rendition, '#')} cursor-pointer" id="{@xml:id}" data-bs-toggle="modal" data-bs-target="#nicht_erfasst">
              <xsl:apply-templates/>
            </span>
          </xsl:when>
          <xsl:otherwise>
              <span class="quotes entity {substring-after(@rendition, '#')} cursor-pointer" id="{@xml:id}" data-bs-toggle="modal" data-bs-target="{@source}">
                <xsl:apply-templates/>
              </span>
          </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:date">
        <span class="date"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:note">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>fna_</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#fn</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:attribute>
            <sup>
                <xsl:number level="any" format="1" count="tei:note"/>
            </sup>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:list[@type='unordered']">
        <xsl:choose>
            <xsl:when test="ancestor::tei:body">
                <ul class="yes-index">
                    <xsl:apply-templates/>
                </ul>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:item">
        <xsl:choose>
            <xsl:when test="parent::tei:list[@type='unordered']|ancestor::tei:body">
                <li><xsl:apply-templates/></li>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:hi">
        <span>
            <xsl:choose>
                <xsl:when test="@rendition = '#em'">
                    <xsl:attribute name="class">
                        <xsl:text>italic</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="@rendition = '#italic'">
                    <xsl:attribute name="class">
                        <xsl:text>italic</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="@rendition = '#smallcaps'">
                    <xsl:attribute name="class">
                        <xsl:text>smallcaps</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="@rendition = '#bold'">
                    <xsl:attribute name="class">
                        <xsl:text>bold</xsl:text>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:ref">
        <a class="ref {@type}" href="{@target}"><xsl:apply-templates/></a>
    </xsl:template>
    <xsl:template match="tei:lg">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="tei:l">
        <xsl:apply-templates/><br/>
    </xsl:template>
    <xsl:template match="tei:p">
       <p class="w-fit-content"><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:table">
        <xsl:element name="table">
            <xsl:attribute name="class">
                <xsl:text>table table-bordered table-striped table-condensed table-hover</xsl:text>
            </xsl:attribute>
            <xsl:element name="tbody">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:row">
        <xsl:element name="tr">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:cell">
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:unclear">
        <abbr title="unclear"><xsl:apply-templates/></abbr>
    </xsl:template>
    <xsl:template match="tei:del">
        <del><xsl:apply-templates/></del>
    </xsl:template>
    <xsl:template match="tei:rs">
        <xsl:choose>
            <xsl:when test="count(tokenize(@ref, ' ')) > 1">
                <xsl:choose>
                    <xsl:when test="@type='person'">
                        <span class="persons {substring-after(@rendition, '#')} cursor-pointer" id="{@xml:id}">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup class="entity">/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='institution'">
                        <span class="institutions {substring-after(@rendition, '#')}" id="{@xml:id}">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup class="entity">/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='place'">
                        <span class="places {substring-after(@rendition, '#')}" id="{@xml:id}">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup class="entity">/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='law'">
                        <span class="legaltexts {substring-after(@rendition, '#')}" id="{@xml:id}">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-bs-toggle="modal" data-bs-target="{replace(.,'/','#')}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup class="entity">/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='work'">
                        <span class="works {substring-after(@rendition, '#')} cursor-pointer" id="{@xml:id}">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-bs-toggle="modal" data-bs-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup class="entity">/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@type='person'">
                        <span class="persons entity {substring-after(@rendition, '#')} cursor-pointer" id="{@xml:id}" data-bs-toggle="modal" data-bs-target="{if (not(@ref) or @ref='') then '#nicht_erfasst' else @ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='institution'">
                        <span class="institutions entity {substring-after(@rendition, '#')} cursor-pointer" id="{@xml:id}" data-bs-toggle="modal" data-bs-target="{@ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='place'">
                        <span class="places entity {substring-after(@rendition, '#')} cursor-pointer" id="{@xml:id}" data-bs-toggle="modal" data-bs-target="{@ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                     <xsl:when test="@type='law'">
                        <span class="legaltexts entity {substring-after(@rendition, '#')}" id="{@xml:id}">
                            <xsl:apply-templates/>
                            <a href="{@ref}" target="_blank" class="align-text-bottom ps-1 link-ext d-none" rel="noopener noreferrer" title="go to {@ref}">
                              <i class="fas fa-external-link-alt fa-sm"/>
                            </a>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='work'">
                      <xsl:choose>
                        <xsl:when test="starts-with(@corresp,'https://fackel')">
                          <span class="works entity {substring-after(@rendition, '#')}" id="{@xml:id}">
                              <xsl:apply-templates/>
                              <a href="{@corresp}" target="_blank" class="align-text-bottom ps-1 link-ext d-none" rel="noopener noreferrer" title="go to {@ref}">
                                <i class="fas fa-external-link-alt fa-sm"/>
                              </a>
                          </span>
                        </xsl:when>
                        <xsl:when test="starts-with(@ref,'https://id.acdh.oeaw.ac.at/legalkraus')">
                          <xsl:variable name="doc_name" select="replace(tokenize(@ref,'/')[last()],'.xml','')"/>
                          <span class="works entity {substring-after(@rendition, '#')}" id="{@xml:id}">
                              <xsl:apply-templates/>
                              <a href="{$doc_name||'.html'}" target="_blank" class="align-text-bottom ps-1 link-ext d-none" rel="noopener noreferrer" title="go to {@ref}">
                                <i class="fas fa-external-link-alt fa-sm"/>
                              </a>
                          </span>
                        </xsl:when>
                        <xsl:when test="(not(@ref) or @ref='') and (not(@corresp) or @corresp='')">
                          <span class="works entity {substring-after(@rendition, '#')} cursor-pointer" id="{@xml:id}" data-bs-toggle="modal" data-bs-target="#nicht_erfasst">
                              <xsl:apply-templates/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span class="works entity {substring-after(@rendition, '#')} cursor-pointer" id="{@xml:id}" data-bs-toggle="modal" data-bs-target="{@ref}">
                              <xsl:apply-templates/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:listPerson">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:person">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="5" />
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        <div class="modal fade" id="{@xml:id}" data-bs-keyboard="false" tabindex="-1" aria-labelledby="{concat(./tei:persName/tei:surname, ', ', ./tei:persName/tei:forename)}" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-0">
                    <div class="modal-header rounded-0 bg-darker-gray">
                        <xsl:variable name="surName" select="./tei:persName/tei:surname"/>
                        <xsl:variable name="foreName" select="./tei:persName/tei:forename"/>
                        <xsl:variable name="fullName">
                            <xsl:choose>
                                <xsl:when test="$surName and $foreName">
                                  <xsl:value-of select="concat($surName,', ',$foreName)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="$surName"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="$fullName"/></h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <xsl:if test="./tei:idno[@subtype='geonames']">
                            <div class="mb-3">
                                <h2 class="fs-6">Geonames ID</h2>
                                <a href="{./tei:idno[@subtype='geonames']}" target="_blank">
                                  <xsl:value-of select="tokenize(./tei:idno[@subtype='geonames'], '/')[4]"/>
                                </a>
                            </div>
                        </xsl:if>
                        <xsl:if test="./tei:idno[@subtype='wikidata']">
                            <div class="mb-3">
                                <h2 class="fs-6">Wikidata ID(s)</h2>
                                <ul class="list-unstyled ps-3">
                                  <xsl:for-each select="./tei:idno[@subtype='wikidata']">
                                      <a href="{current()}" target="_blank">
                                        <xsl:value-of select="tokenize(current(), '/')[last()]"/>
                                      </a>
                                  </xsl:for-each>
                                </ul>
                            </div>
                        </xsl:if>
                        <xsl:if test="./tei:idno[@subtype='gnd']">
                            <div class="mb-3">
                                <h2 class="fs-6">GND ID(s)</h2>
                                <ul class="list-unstyled ps-3">
                                    <xsl:for-each select="./tei:idno[@subtype='gnd']">
                                        <a href="{current()}" target="_blank">
                                          <xsl:value-of select="tokenize(current(), '/')[last()]"/>
                                        </a>
                                    </xsl:for-each>
                                </ul>
                            </div>
                        </xsl:if>
                        <xsl:if test="./tei:listEvent">
                            <div class="mb-3">
                                <h2 class="fs-6">Erwähnungen</h2>
                                <ul class="list-unstyled ps-3">
                                    <xsl:for-each select=".//tei:event">
                                        <xsl:variable name="linkToDocument">
                                            <xsl:value-of select="replace(tokenize(data(.//@target), '/')[last()], '.xml', '.html')"/>
                                        </xsl:variable>
                                        <xsl:choose>
                                            <xsl:when test="position() lt $showNumberOfMentions + 1">
                                                <li>
                                                    <xsl:value-of select=".//tei:title"/><xsl:text> </xsl:text>
                                                    <a href="{$linkToDocument}">
                                                        <i class="fas fa-external-link-alt"></i>
                                                    </a>
                                                </li>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:for-each>
                                </ul>
                            </div>
                        </xsl:if>
                        <p>
                            Anzahl der Erwähnungen limitiert, klicke <a class="link-primary" href="{$selfLink}">hier</a> für eine vollständige Auflistung
                        </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="tei:listPlace">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:place">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="5" />
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        <div class="modal fade" id="{@xml:id}" data-bs-keyboard="false" tabindex="-1" aria-labelledby="{if(./tei:settlement) then(./tei:settlement/tei:placeName) else (./tei:placeName[1])}" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-0">
                    <div class="modal-header rounded-0  bg-darker-gray">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="if(./tei:settlement) then(./tei:settlement/tei:placeName) else (./tei:placeName[1])"/></h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <xsl:if test="./tei:country">
                            <div class="mb-3">
                                <h2 class="fs-6">Country</h2>
                                <xsl:value-of select="./tei:country"/>
                            </div>
                        </xsl:if>
                        <xsl:if test="./tei:idno[@type='GND']/text()">
                            <div class="mb-3">
                                <h2 class="fs-6">GND</h2>
                                <a href="{./tei:idno[@type='GND']}" target="_blank">
                                    <xsl:value-of select="tokenize(./tei:idno[@type='GND'], '/')[last()]"/>
                                </a>
                            </div>
                        </xsl:if>
                        <xsl:if test="./tei:idno[@type='WIKIDATA']/text()">
                            <div class="mb-3">
                                <h2 class="fs-6">Wikidata</h2>
                                <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                    <xsl:value-of select="tokenize(./tei:idno[@type='WIKIDATA'], '/')[last()]"/>
                                </a>
                            </div>
                        </xsl:if>
                        <xsl:if test="./tei:idno[@type='GEONAMES']/text()">
                            <div class="mb-3">
                                <h2 class="fs-6">Geonames</h2>
                                <a href="{./tei:idno[@type='GEONAMES']}" target="_blank">
                                    <xsl:value-of select="tokenize(./tei:idno[@type='GEONAMES'], '/')[4]"/>
                                </a>
                            </div>
                        </xsl:if>
                        <xsl:if test="./tei:listEvent">
                          <div class="mb-3">
                            <h2 class="fs-6">Erwähnungen</h2>
                            <ul class="list-unstyled ps-3">
                                <xsl:for-each select=".//tei:event">
                                    <xsl:variable name="linkToDocument">
                                        <xsl:value-of select="replace(tokenize(data(.//@target), '/')[last()], '.xml', '.html')"/>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="position() lt $showNumberOfMentions + 1">
                                            <li>
                                                <xsl:value-of select=".//tei:title"/><xsl:text> </xsl:text>
                                                <a href="{$linkToDocument}">
                                                    <i class="fas fa-external-link-alt"></i>
                                                </a>
                                            </li>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:for-each>
                            </ul>
                          </div>
                        </xsl:if>
                        <p>
                          Anzahl der Erwähnungen limitiert, klicke <a class="link-primary" href="{$selfLink}">hier</a> für eine vollständige Auflistung
                        </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:listOrg">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:org">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="5" />
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        <div class="modal fade" id="{@xml:id}" data-bs-keyboard="false" tabindex="-1" aria-labelledby="{./tei:orgName}" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-0">
                    <div class="modal-header rounded-0 bg-darker-gray">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="./tei:orgName[1]"/></h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      <xsl:if test="./tei:idno[@subtype='geonames']">
                        <div class="mb-3">
                            <h2 class="fs-6">Geonames ID</h2>
                            <a href="{./tei:idno[@subtype='geonames']}" target="_blank">
                                <xsl:value-of select="tokenize(./tei:idno[@subtype='geonames'], '/')[4]"/>
                            </a>
                        </div>
                      </xsl:if>
                      <xsl:if test="./tei:idno[@subtype='wikidata']">
                        <div class="mb-3">
                            <h2 class="fs-6">Wikidata ID(s)</h2>
                            <ul class="list-unstyled ps-3">
                                <xsl:for-each select="./tei:idno[@subtype='wikidata']">
                                    <a href="{current()}" target="_blank">
                                      <xsl:value-of select="tokenize(current(), '/')[last()]"/>
                                    </a>
                                </xsl:for-each>
                            </ul>
                        </div>
                      </xsl:if>
                      <xsl:if test="./tei:idno[@subtype='gnd']">
                        <div class="mb-3">
                            <h2 class="fs-6">GND ID</h2>
                            <a href="{./tei:idno[@subtype='gnd']}" target="_blank">
                              <xsl:value-of select="tokenize(./tei:idno[@subtype='gnd'], '/')[last()]"/>
                            </a>
                        </div>
                      </xsl:if>
                      <xsl:if test="./tei:listEvent">
                        <div class="mb-3">
                          <h2 class="fs-6">Erwähnungen</h2>
                          <ul class="list-unstyled ps-3">
                              <xsl:for-each select=".//tei:event">
                                  <xsl:variable name="linkToDocument">
                                      <xsl:value-of select="replace(tokenize(data(.//@target), '/')[last()], '.xml', '.html')"/>
                                  </xsl:variable>
                                  <xsl:choose>
                                      <xsl:when test="position() lt $showNumberOfMentions + 1">
                                          <li>
                                              <xsl:value-of select=".//tei:title"/><xsl:text> </xsl:text>
                                              <a href="{$linkToDocument}">
                                                  <i class="fas fa-external-link-alt"></i>
                                              </a>
                                          </li>
                                      </xsl:when>
                                  </xsl:choose>
                              </xsl:for-each>
                          </ul>
                        </div>
                      </xsl:if>
                      <p>
                          Anzahl der Erwähnungen limitiert, klicke <a class="link-primary" href="{$selfLink}">hier</a> für eine vollständige Auflistung
                      </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="tei:listBibl">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:bibl">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="5" />
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        <div class="modal fade" id="{@xml:id}" data-bs-keyboard="false" tabindex="-1" aria-labelledby="./tei:title[@type='main']" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-0">
                    <div class="modal-header rounded-0 bg-darker-gray">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="./tei:title[@type='main']"/></h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      <xsl:if test="./tei:author">
                      <div class="mb-3">
                        <h2 class="fs-6">Autor(en)</h2>
                        <ul class="list-unstyled ps-3">
                            <xsl:for-each select="./tei:author">
                                <li>
                                    <a href="{@xml:id}.html">
                                        <xsl:value-of select="current()"/>
                                    </a>
                                </li>
                            </xsl:for-each>
                        </ul>
                      </div>
                      </xsl:if>
                      <xsl:if test="./tei:idno[@subtype='geonames']">
                        <div class="mb-3">
                          <h2 class="fs-6">Geonames ID</h2>
                          <a href="{./tei:idno[@subtype='geonames']}" target="_blank">
                              <xsl:value-of select="tokenize(./tei:idno[@subtype='geonames'], '/')[4]"/>
                          </a>
                        </div>
                      </xsl:if>
                      <xsl:if test="./tei:idno[@subtype='wikidata']">
                        <div class="mb-3">
                          <h2 class="fs-6">Wikidata ID</h2>
                          <a href="{./tei:idno[@subtype='wikidata']}" target="_blank">
                              <xsl:value-of select="tokenize(./tei:idno[@subtype='wikidata'], '/')[last()]"/>
                          </a>
                        </div>
                      </xsl:if>
                      <xsl:if test="./tei:idno[@subtype='gnd']">
                        <div class="mb-3">
                            <h2 class="fs-6">GND ID</h2>
                            <a href="{./tei:idno[@subtype='gnd']}" target="_blank">
                                    <xsl:value-of select="tokenize(./tei:idno[@subtype='gnd'], '/')[last()]"/>
                            </a>
                        </div>
                      </xsl:if>
                      <xsl:if test="./tei:listEvent">
                        <div class="mb-3">
                            <h2 class="fs-6">Erwähnungen</h2>
                            <ul class="list-unstyled ps-3">
                                <xsl:for-each select=".//tei:event">
                                    <xsl:variable name="linkToDocument">
                                        <xsl:value-of select="replace(tokenize(data(.//@target), '/')[last()], '.xml', '.html')"/>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="position() lt $showNumberOfMentions + 1">
                                            <li>
                                                <xsl:value-of select=".//tei:title"/><xsl:text> </xsl:text>
                                                <a href="{$linkToDocument}">
                                                    <i class="fas fa-external-link-alt"></i>
                                                </a>
                                            </li>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:for-each>
                            </ul>
                        </div>
                      </xsl:if>
                      <p>
                        Anzahl der Erwähnungen limitiert, klicke <a class="link-primary" href="{$selfLink}">hier</a> für eine vollständige Auflistung
                      </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div> 
    </xsl:template>

    <!-- <xsl:template match="tei:rs[@ref or @key]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="data-toggle">modal</xsl:attribute>
                <xsl:attribute name="data-target">
                    <xsl:value-of select="data(@ref)"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template> -->
    
</xsl:stylesheet>