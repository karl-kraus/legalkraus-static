<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:local="http://legalraus.acdh.oeaw.ac.at" version="3.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    <xsl:mode on-no-match="deep-skip"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="partials/osd-container.xsl"/>
    <xsl:import href="partials/tei-facsimile.xsl"/>
    <xsl:variable name="cases" as="array(*)">
        <xsl:variable name="case-objects" as="map(*)*">
            <xsl:for-each select="collection('../data/cases_tei?select=*.xml')//tei:TEI[descendant::tei:origDate[@notBefore-iso]]">
                <xsl:sort select="number(translate(@xml:id, 'C_.xml', ''))"/>
                <xsl:variable name="id" select="replace(@xml:id, '.xml', '')" as="xs:string"/>
                <xsl:variable name="keywords" select="array {current()//tei:keywords//tei:term/data()}"/>
                <xsl:variable name="year" select="year-from-date(xs:date(current()//tei:teiHeader//tei:origDate/@notBefore-iso))" as="xs:integer"/>
                <xsl:copy-of select="
                        map {
                            'name': current()//tei:title/data(),
                            'keywords': $keywords,
                            'id': $id,
                            'year': $year
                        }"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="array {$case-objects}"/>
    </xsl:variable>
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html lang="de">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="'Karl Kraus Rechtsakten - Fallstatistik'"/>
                </xsl:call-template>
                <script src="js/vendor/highcharts.js"/>
            </head>
            <body class="page">
                <div class="hfeed site d-flex flex-column min-vh-100" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="p-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.html">Home</a>
                            </li>
                            <li class="breadcrumb-item active text-truncate" aria-current="page">
                                <xsl:value-of select="'Fallstatistik'"/>
                            </li>
                        </ol>
                    </nav>
                    <div class="container">
                        <div class="col-12">
                            <xsl:apply-templates select="//skos:Concept[skos:prefLabel/text() = ('Rechtsbereich', 'Art der Akte / des Deliktes', 'Delikttyp', 'Ausgang / Ende des Verfahrens')]" />
                        </div>
                    </div>
                    <xsl:call-template name="html_footer">
                        <xsl:with-param name="include_jquery" select="false()"/>
                    </xsl:call-template>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="skos:prefLabel" mode="concept-cases">
        <xsl:variable name="label" select="." as="xs:string"/>
        <xsl:map>
            <xsl:map-entry key="'name'" select="$label"/>
            <xsl:map-entry key="'data'" select="$cases?*[$label = .?keywords]"/>
        </xsl:map>
    </xsl:template>
    <xsl:template match="skos:Concept">
        <xsl:variable name="uri" select="@rdf:about" as="xs:string"/>
        <xsl:variable name="concepts-cases" as="array(map(*))">
            <xsl:variable name="items" as="map(*)*">
                <xsl:for-each select="skos:narrower">
                    <xsl:apply-templates select="(root()//skos:Concept[@rdf:about = current()/@rdf:resource]/skos:prefLabel, current()/skos:Concept/skos:prefLabel)" mode="concept-cases"/>
                </xsl:for-each>
            </xsl:variable>
            <xsl:copy-of select="array {$items}"/>
        </xsl:variable>
        <xsl:variable name="id" select="skos:notation" as="xs:string"/>
        <xsl:variable name="label" select="skos:prefLabel" as="xs:string"/>
        <xsl:variable name="years" as="array(*)">
            <xsl:variable name="tmp" as="xs:integer*">
                <xsl:for-each select="$concepts-cases?*">

                    <xsl:for-each select="current()?data">
                        <xsl:sequence>
                            <xsl:value-of select="current()?year"/>
                        </xsl:sequence>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:variable>
            <xsl:copy-of select="array {sort(distinct-values($tmp))}"/>
        </xsl:variable>
        <xsl:variable name="series" as="array(*)">
            <xsl:variable name="tmp" as="map(*)*">
                <xsl:for-each select="$concepts-cases?*">
                    <xsl:variable name="cases" select="current()?data"/>
                    <xsl:map>
                        <xsl:map-entry key="'visible'" select="current()?name = array:head($concepts-cases)?name"/>
                        <xsl:map-entry key="'name'" select="current()?name"/>
                        <xsl:variable name="counts" as="xs:integer*">
                            <xsl:for-each select="$years?*">
                                <xsl:value-of select="count($cases[current() = .?year])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:map-entry key="'data'" select="array {$counts}"/>
                    </xsl:map>
                </xsl:for-each>
            </xsl:variable>
            <xsl:copy-of select="array {$tmp}"/>
        </xsl:variable>
        <xsl:variable name="tmp" as="xs:integer*">
            <xsl:for-each select="$years?*">
                <xsl:value-of select="number(count($cases?*[current() = .?year]))"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="totals" select="array {$tmp}" as="array(xs:integer*)"/>

        <div id="{$id}-chart-container" class="chart-container" data-series="{serialize($totals,map{'method':'json'})}" data-title="{$label}">
            <script>
                (function() {
                    const chartTitle = '<xsl:value-of select="$label"/>';
                    const years = <xsl:value-of select="serialize($years, map {'method': 'json'})"/>;
                    const totals = <xsl:value-of select="serialize($totals, map {'method': 'json'})"/>;
                    const chartContainerId = '<xsl:value-of select="$id || '-chart-container'"/>';
                    let series = <xsl:value-of select="serialize($series, map {'method': 'json'})"/>;
                    
                    
                    series[0].color = '#C6C2BC';
                     
                    totalSeries = {
                        name: "Gesamt",
                        type: "line",
                        stacking: false,
                        marker: { enabled: false },
                        showInLegend: false,
                        color: "#FF0000",
                        data: totals,
                    };
                    series.push(totalSeries);
                    Highcharts.AST.allowedReferences.push('cases.html');
                    Highcharts.chart(chartContainerId, {
                        chart: {
                            type: 'area',
                            plotBackgroundColor:'#eeedeb'
                        },
                        title: {
                            text: chartTitle,
                            style: {
                                fontWeight:'normal'
                            }
                        },
                        xAxis: {
                            allowDecimals: false,
                            categories: [...new Set(years)],
                        },
                        yAxis: {
                            title: {
                                text: 'Fälle'
                            }
                        },
                        series: series,
                        legend: {
                            squareSymbol:false,
                            useHTML:true,
                            labelFormatter: function () {
                            return `${this.name}<a class="legend-link ps-1" target="_blank" href="cases.html?filter=keyword-${{this.chart.title.textStr}}_${{this.name}}">&#x2192;</a>`
                            },
                            itemStyle:{
                                'text-decoration':'none',
                                'font-weight':'bold'
                                
                            },
                        },
                        tooltip: { shared: true, valueSuffix: " Fälle" },
                        plotOptions: {
                            area: {
                                marker: {
                                    enabled: false,
                                    symbol: 'circle',
                                    radius: 2,
                                    states: {
                                        hover: {
                                            enabled: true
                                        }
                                    }
                                }
                            }
                        },
                    })
                })();
</script>
</div>
</xsl:template>
</xsl:stylesheet>
