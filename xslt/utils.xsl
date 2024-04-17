<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:v-on="http://example.com/v-on" xmlns:utils="http://example.com/utils"
    exclude-result-prefixes="xs tei utils" version="2.0">
<!-- fragmenting function based on https://wiki.tei-c.org/index.php/Milestone-chunk.xquery -->
    <xsl:variable name="teiHeader" select="//tei:teiHeader"/>
    <xsl:variable name="facs" select="//tei:facsimile"/>
    <xsl:function name="utils:split">
        <xsl:param name="ms1" as="element()"/>
        <xsl:param name="ms2" as="element()"/>
        <xsl:param name="node" as="node()*"/>
        <xsl:choose>
            <xsl:when test="$node instance of element()">
                <xsl:choose>
                    <xsl:when test="$node is $ms1">
                        <xsl:copy-of select="$node"/>
                    </xsl:when>
                     <xsl:when test="$node/name() = 'back'"></xsl:when>
                    <xsl:when test="
                            some $n in $node/descendant::*
                                satisfies ($n is $ms1 or $n is $ms2)">
                        <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="{$node/local-name()}">
                            <xsl:copy-of select="
                                    for $i in ($node/node() | $node/@*)
                                    return
                                        utils:split($ms1, $ms2, $i)"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="$node >> $ms1 and $node &lt;&lt; $ms2">
                        <xsl:copy-of select="$node"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$node instance of attribute()">
                <xsl:copy-of select="$node"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="$node >> $ms1 and $node &lt;&lt; $ms2">
                    <xsl:copy-of select="$node"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
     </xsl:function>
    </xsl:stylesheet>