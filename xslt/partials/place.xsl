<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">

    <xsl:template match="tei:place" name="place_detail">
        <dl>
            <dt>Ortsname</dt>
            <dd>
                <xsl:choose>
                    <xsl:when test="./tei:settlement/tei:placeName[1]/text()">
                        <xsl:value-of select="./tei:settlement/tei:placeName[1]/text()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="./tei:placeName[1]/text()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </dd>
            <xsl:if test="./tei:location[@type='located_in_place']">
                <dt>Teil von</dt>
                <xsl:for-each select="./tei:location[@type='located_in_place']">
                    <dd>
                        <a href="{./tei:placeName/@key}.html">
                            <xsl:value-of select="./tei:placeName"/>
                        </a>            
                    </dd>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="./tei:country">
                <dt>Land</dt>
                <dd>
                    <xsl:value-of select="./tei:country"/>
                </dd>
            </xsl:if>
            <xsl:if test="./tei:desc[@type='entity_type']">
                <dt>Ortstype</dt>
                <dd>
                   <xsl:value-of select="./tei:desc[@type='entity_type']"/>
                </dd>
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
