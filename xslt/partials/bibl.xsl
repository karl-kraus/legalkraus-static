<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">


    <xsl:template match="tei:bibl" name="bibl_detail">
        <dl>
            <xsl:if test="./tei:title[@type='werk_bibliografische-angabe']">
                <dt>Vollzitat/Anno Link</dt>
                <xsl:for-each select="./tei:title[@type='werk_bibliografische-angabe']">
                    <dd>
                        <xsl:choose>
                            <xsl:when test="starts-with(./text(), 'http')">
                                <a href="{./text()}"><xsl:value-of select="./text()"/></a>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="./text()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </dd>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="./tei:author">
                <dt>AutorInnen</dt>
                <xsl:for-each select="./tei:author">
                    <dd>
                        <xsl:value-of select="."/>
                        <a class="ps-2" title="zum PMB-Eintrag von {./text()}"
                            href="{concat('https://pmb.acdh.oeaw.ac.at/entity/', replace(@key, 'person__', ''))}">
                            <i class="fas fa-external-link-alt fa-sm"/>
                        </a>
                    </dd>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="./tei:date">
                <dt>Erscheinungsjahr, -zeitraum</dt>
                <xsl:for-each select="./tei:date">
                    <dd>
                        <xsl:value-of select="normalize-space(./text())"/>
                    </dd>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="./tei:note[@type='work_kind']/text()">
                <dt>Textgattung</dt>
                <xsl:for-each select="./tei:note[@type='work_kind']">
                    <dd>
                        <xsl:value-of select="normalize-space(./text())"/>
                    </dd>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="./tei:idno[@type = 'URL']">
                <dt>links</dt>
                <xsl:for-each select="./tei:idno[@type = 'URL']">
                    <xsl:choose>
                        <xsl:when test="contains(./text(), 'pmb.acdh.oeaw.ac.at/entity/')">
                            <dd>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="./text()"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="./text()"/>
                                </a>
                            </dd>
                        </xsl:when>
                        <xsl:when test="contains(./text(), 'wikidata.org')">
                            <dd>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="./text()"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="./text()"/>
                                </a>
                            </dd>
                        </xsl:when>
                        <xsl:when test="contains(./text(), 'geonames')">
                            <dd>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="./text()"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="./text()"/>
                                </a>
                            </dd>
                        </xsl:when>
                        <xsl:when test="contains(./text(), 'd-nb.info/gnd')">
                            <dd>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="./text()"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="./text()"/>
                                </a>
                            </dd>
                        </xsl:when>
                    </xsl:choose>
                    
                    
                </xsl:for-each>
                
            </xsl:if>
        </dl>


    </xsl:template>
</xsl:stylesheet>
