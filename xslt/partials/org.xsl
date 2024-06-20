<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    <xsl:template match="tei:org" name="org_detail">
        <dl>
            <xsl:if test="./tei:orgName">
                <dt>Name</dt>
                <xsl:for-each select="./tei:orgName">
                    <xsl:choose>
                        <xsl:when test="./@type eq 'werk_link-anno'"></xsl:when>
                        <xsl:otherwise>
                            <dd><xsl:value-of select="."/></dd>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="./tei:desc[@type='entity_type']">
               <dt>Beschreibung</dt>
                    <dl>
                        <xsl:value-of select="./tei:desc[@type='entity_type']"/>
                    </dl>
            </xsl:if>
            <xsl:if test="./tei:location[@type='located_in_place']">
                <dt>Teil von</dt>
                <xsl:for-each select="./tei:location">
                    <dl>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat(./tei:placeName/@key, '.html')"/>
                            </xsl:attribute>
                            <xsl:value-of select="./tei:placeName/text()"/>
                        </a>
                    </dl>
                </xsl:for-each>
            </xsl:if>
            <dt>links</dt>
            <xsl:for-each select="./tei:idno[@type='URL']">
                <dl>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="./text()"/>
                        </xsl:attribute>
                        <xsl:value-of select="./text()"/>
                    </a>
                </dl>
            </xsl:for-each>
        </dl>
    </xsl:template>

</xsl:stylesheet>
