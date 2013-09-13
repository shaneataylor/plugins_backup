<?xml version="1.0" encoding="UTF-8"?>
<!-- 
  Copyright 2001-2011 Syncro Soft SRL. All rights reserved.
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:func="http://www.oxygenxml.com/xsdDoc/functions" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xpath-default-namespace="http://www.oxygenxml.com/ns/doc/schema-internal" 
    exclude-result-prefixes="#all">
    <xsl:param name="mainFile" required="yes"/>
    <!-- currently .tmp -->
    <xsl:param name="intermediateXmlExtension" required="yes"/>
    <xd:doc>
        <xd:desc>The oXygen family product used to generate the documentation.
        <xd:p> Possible values:
          <xd:ul>
              <xd:li>Editor (default value)</xd:li>
              <xd:li>Developer</xd:li>
          </xd:ul>
        </xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:param name="distribution">Editor</xsl:param>
    
    <xsl:output method="xml" encoding="UTF-8" version="1.0" omit-xml-declaration="no"
        doctype-public="-//OASIS//DTD DITA Reference//EN"
        doctype-system="reference.dtd" indent="yes"
        exclude-result-prefixes="#all"/>

    <!-- something like '.html' -->
    <xsl:variable name="extension">
        <xsl:variable name="ext" select="func:substring-after-last($mainFile, '.')"/>
        <xsl:choose>
            <xsl:when test="string-length($ext) = 0">
                <xsl:text></xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('.', $ext)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="rootID">
        <xsl:variable name="rID" select="func:substring-before-last($mainFile, '.')"/>
        <xsl:choose>
            <xsl:when test="string-length($rID) = 0">
                <xsl:value-of select="$mainFile"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$rID"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="refCountSpecifiers">
        <xsl:text>\*|\{0,1\}|\+</xsl:text>
    </xsl:variable>
    
    <xsl:variable name="schemaHierarchyFile">schHierarchy.html</xsl:variable>

    <xsl:variable name="chunkValueLocation">location</xsl:variable>
    <xsl:variable name="chunkValueNamespace">namespace</xsl:variable>
    <xsl:variable name="chunkValueComponent">component</xsl:variable>
    <xsl:variable name="chunkValueNone">none</xsl:variable>
    
    <xd:doc>
      <xd:desc>The root element of the documentation.</xd:desc>
    </xd:doc>
    <xsl:variable name="documentationRoot" select="/schemaDoc"/>
    
    <xsl:variable name="splitInfo" select="$documentationRoot/splitInfo"/>
    
    <xd:doc>
        <xd:desc>Points to the node that contains schema hierarchy. Is empty if hierarchy was not generated.</xd:desc>
    </xd:doc>
    <xsl:variable name="resourceHierarchyNode" select="$documentationRoot/schemaHierarchy"/>
    
    <xd:doc>
        <xd:desc>When all the  components are in the same file (no split after some criteria) we will use FRAMES. So the index will be redirected in a $indexFile
            and the components in a $mainFile. The output file will only contain the FRAMESET</xd:desc>
    </xd:doc>
    <xsl:variable name="isChunkMode" as="xs:boolean"> false </xsl:variable>

    <xd:doc>
        <xd:desc>When  NO CHUNKS we will generate a frame html. The index in one file and the content in other</xd:desc>
    </xd:doc>
    <xsl:variable name="indexFile"
        select="concat(func:substring-before-last($splitInfo/@indexLocation, $intermediateXmlExtension), $extension)"/>
    <xsl:variable name="indexFileComp"
        select="concat(func:substring-before-last($splitInfo/@indexLocation, $intermediateXmlExtension), 'comp', $extension)"/>
    <xsl:variable name="indexFileNamespace"
        select="concat(func:substring-before-last($splitInfo/@indexLocation, $intermediateXmlExtension), 'ns', $extension)"/>

    <xsl:variable name="mainFrame">mainFrame</xsl:variable>
    <xsl:variable name="indexFrame">indexFrame</xsl:variable>


    <xd:doc>
        <xd:desc>Used to construct an id for identifying a property of  a component. This prefix will be added to the unique component id</xd:desc>
    </xd:doc>
    <xsl:variable name="idsPrefixMap">
        <xsl:copy-of select="$schemaIdsPrefixMap"/>
    </xsl:variable>
    
    <xd:doc>
        <xd:desc>Used to construct an id for identifying a property of a schema component. This prefix will be added to the unique component id</xd:desc>
    </xd:doc>
    <xsl:variable name="schemaIdsPrefixMap">
        <entry key="properties">properties_</entry>
        <entry key="defaultOpenContent">defaultOpenContent_</entry>
        <entry key="usedBy">usedBy_</entry>
        <entry key="attributes">attributes_</entry>
        <entry key="asserts">asserts_</entry>
        <entry key="typeAlternatives">typeAlternatives_</entry>
        <entry key="children">children_</entry>
        <entry key="source">source_</entry>
        <entry key="instance">instance_</entry>
        <entry key="facets">facets_</entry>
        <entry key="diagram">diagram_</entry>
        <entry key="annotations">annotations_</entry>
        <entry key="constraints">identityConstraints_</entry>
        <entry key="model">model_</entry>
    </xsl:variable>
    
    <xd:doc>
        <xd:desc>Mapping between directive types and icons. Is used in 
            the hierarchy tree.</xd:desc>
    </xd:doc>
    <xsl:variable name="scHierarchyIcons">
        <xsl:copy-of select="$schemaHierarchyIcons"/>
    </xsl:variable>
    
    <xd:doc>
        <xd:desc>Part of the tooltip presented on a from the hierarchy view.</xd:desc>
    </xd:doc>
    <xsl:variable name="scHierarchyTooltip">
        <xsl:copy-of select="$schemaHierarchyTooltip"/>
    </xsl:variable>
    
    <xd:doc>
        <xd:desc>Mapping between schema directive types and icons. Is used in 
        the schemas hierarchy tree.</xd:desc>
    </xd:doc>
    <xsl:variable name="schemaHierarchyIcons">
        <entry key="import">img/Import12.gif</entry>
        <entry key="include">img/Include12.gif</entry>
        <entry key="redefine">img/Redefine12.gif</entry>
        <entry key="override">img/Override12.gif</entry>
    </xsl:variable>
    
    
    <xd:doc>
        <xd:desc>Part of the tooltip presented on a schema from the hierarchy view.</xd:desc>
    </xd:doc>
    <xsl:variable name="schemaHierarchyTooltip">
        <entry key="import">Imported by </entry>
        <entry key="include">Included by</entry>
        <entry key="redefine">Redefined by</entry>
        <entry key="override">Overridden by</entry>
    </xsl:variable>

    <xsl:variable name="buttonPrefix">button_</xsl:variable>
    
    <xd:doc>
        <xd:desc>Prefix used to generate the title of a documentation HTML page.</xd:desc>
    </xd:doc>
    <xsl:variable name="documentationPageTitle">Schema documentation for</xsl:variable>

    <xsl:key name="elementQname" match="/schemaDoc/element/qname" use="text()"/>
    <xsl:key name="elementUsesID" match="/schemaDoc/element" use="model/descendant::*/@refId"/>
    
    <xsl:variable name="propertiesBoxes">        
         
    </xsl:variable>
    
    <xsl:variable name="modelBoxes">        
         
    </xsl:variable>
    
    <xsl:variable name="defaultOpenContentBoxes">        
         
    </xsl:variable>
    <xsl:variable name="facetsBoxes">        
        
    </xsl:variable>
    <xsl:variable name="usedByBoxes">
        
    </xsl:variable>
    <xsl:variable name="attributesBoxes">
        
    </xsl:variable>
    <xsl:variable name="assertsBoxes">
        
    </xsl:variable>
    <xsl:variable name="typeAlternativesBoxes">
    
    </xsl:variable>
    <xsl:variable name="sourceBoxes">
        
    </xsl:variable>
    <xsl:variable name="instanceBoxes">        
        
    </xsl:variable>
    <xsl:variable name="diagramBoxes">        
        
    </xsl:variable>
    <xsl:variable name="annotationBoxes">        
        
    </xsl:variable>
    <xsl:variable name="identityConstraintsBoxes">        
        
    </xsl:variable>
    
    
    <xsl:function name="func:getDivId" as="xs:string">
        <xsl:param name="node"/>
        <xsl:value-of
            select="concat($idsPrefixMap/*[@key=local-name($node)]/text(), $node/parent::node()/@id)"
        />
    </xsl:function>

    <xsl:function name="func:getButtonId" as="xs:string">
        <xsl:param name="node"/>
        <xsl:value-of select="concat($buttonPrefix/text() , func:getDivId($node))"/>
    </xsl:function>

    <xsl:variable name="schemaTypeLabels">
        <entry key="main">main-schema</entry>
        <entry key="include">included-schema</entry>
        <entry key="import">imported-schema</entry>
        <entry key="redefine">redefined-schema</entry>
        <entry key="override">overridden-schema</entry>
    </xsl:variable>

    <xd:doc>
        <xd:desc>Defines labels for all XML Schema component types.</xd:desc>
    </xd:doc>
    <xsl:variable name="schemaComponentTypes">
        <entry key="Element">element</entry>
        <entry key="Attribute">attribute</entry>
        <entry key="Complex_Type">complex-type</entry>
        <entry key="Element_Group">element-group</entry>
        <entry key="Attribute_Group">attribute-group</entry>
        <entry key="Simple_Type">simple-type</entry>
        <entry key="Schema">schema</entry>
        <entry key="Notation">notation</entry>
    </xsl:variable>

    <xsl:variable name="componentTypeLabels">
        <xsl:copy-of select="$schemaComponentTypes"/>
    </xsl:variable>

    <xd:doc>
        <xd:desc>Returns the label/description for the given component key/type.</xd:desc>
    </xd:doc>
    <xsl:function name="func:getComponentTypeLabel" as="xs:string">
        <xsl:param name="compKey" as="xs:string"/>
        <xsl:value-of select="$componentTypeLabels/*:entry[@key=$compKey]/text()"/>
    </xsl:function>

    <xd:doc>
        <xd:desc>Build a title message
            <xd:ul>
                <xd:li>If the documentation was splited by namespace we present something like: "Documentation for namespace 'ns'"</xd:li>
                <xd:li>If the documentation was splited by location we present something like: "Documentation for 'Schema.xsd'"</xd:li>
                <xd:li>If no split we always present: "Documentation for 'MainSchema.xsd'" and this function will not be used</xd:li>
            </xd:ul>
        </xd:desc>
    </xd:doc>
    <xsl:function name="func:getTitle" as="xs:string">
        <xsl:param name="ref"/>
        <xsl:param name="criteria"/>
        <xsl:variable name="message">
            <xsl:text>updatePageTitle('</xsl:text>
            <xsl:choose>
                <xsl:when test="compare($criteria, $chunkValueLocation) = 0">
                    <!-- The split is done after the location -->
                    <xsl:value-of select="func:getLocationChunkTitle($ref/@schemaLocation)"/>
                </xsl:when>
                <xsl:when test="compare($criteria, $chunkValueNamespace) = 0">
                    <!-- The split is done after the namespace -->
                    <xsl:variable name="namespace" select="$ref/@ns"/>
                    <xsl:choose>
                        <xsl:when test="compare('', $namespace) = 0">
                            <xsl:value-of select="func:getNamespaceChunkTitle('NO_NAMESPACE')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="func:getNamespaceChunkTitle($namespace)"/>
                        </xsl:otherwise>
                    </xsl:choose>
<!--                    <xsl:value-of select="func:getNamespaceChunkTitle($namespace)"/>-->
                </xsl:when>
                <xsl:when test="compare($criteria, $chunkValueComponent) = 0">
                    <!-- The split is done after the component -->
                    <xsl:value-of select="func:getComponentChunkTitle($ref/text())"/>
                </xsl:when>
            </xsl:choose>
            <xsl:text>')</xsl:text>
        </xsl:variable>
        <xsl:value-of select="$message"/>
    </xsl:function>

    <xsl:function name="func:getNamespaceChunkTitle" as="xs:string">
        <xsl:param name="ns"/>
        <xsl:variable name="toReturn">
            <xsl:choose>
                <xsl:when test="compare($ns, 'NO_NAMESPACE') = 0">
                    <xsl:value-of select="$documentationPageTitle"/><xsl:text> "No namespace"</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$documentationPageTitle"/><xsl:text> namespace </xsl:text>
                    <xsl:value-of select="$ns"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$toReturn"/>
    </xsl:function>

    <xsl:function name="func:getComponentChunkTitle" as="xs:string">
        <xsl:param name="qName"/>
        <xsl:variable name="toReturn">
            <xsl:value-of select="$documentationPageTitle"/><xsl:text> component </xsl:text>
            <xsl:value-of select="$qName"/>
        </xsl:variable>
        <xsl:value-of select="$toReturn"/>
    </xsl:function>

    <xsl:function name="func:getLocationChunkTitle" as="xs:string">
        <xsl:param name="location"/>
        <xsl:variable name="toReturn">
            <xsl:value-of select="$documentationPageTitle"/><xsl:text> </xsl:text>
            <xsl:value-of select="$location"/>            
        </xsl:variable>
        <xsl:value-of select="$toReturn"/>
    </xsl:function>

    <xd:doc>
        <xd:desc>Get the title of the html page by analyzing the splitInfo element </xd:desc>
    </xd:doc>
    <xsl:function name="func:getTitleFromSplitInfo" as="xs:string">
        <xsl:param name="splitInfo"/>
        <xsl:choose>
            <xsl:when test="compare($splitInfo/@criteria, $chunkValueNamespace) = 0">
                <xsl:value-of select="func:getNamespaceChunkTitle($splitInfo/@value)"/>
            </xsl:when>
            <xsl:when test="compare($splitInfo/@criteria, $chunkValueLocation) = 0">
                <xsl:value-of select="func:getLocationChunkTitle($splitInfo/@value)"/>
            </xsl:when>
            <xsl:when test="compare($splitInfo/@criteria, $chunkValueComponent) = 0">
                <xsl:value-of select="func:getComponentChunkTitle($splitInfo/@value)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="func:getLocationChunkTitle(func:getMainResourceName())"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>Get the name of the main documentation resource.</xd:desc>
    </xd:doc>
    <xsl:function name="func:getMainResourceName" as="xs:string">
        <xsl:value-of select="$documentationRoot/schema[compare(@type, 'main') = 0]/qname"/>
    </xsl:function>

    <xd:doc>
        <xd:desc>Get the substring before the last occurence of the given substring </xd:desc>
    </xd:doc>
    <xsl:function name="func:substring-before-last" as="xs:string">
        <xsl:param name="string"/>
        <xsl:param name="searched"/>
        <xsl:variable name="toReturn">
            <xsl:choose>
                <xsl:when test="contains($string, $searched)">
                    <xsl:variable name="before"
                        select="substring-before($string, $searched)"/>
                    
                    <xsl:variable name="rec" 
                        select="func:substring-before-last(substring-after($string, $searched), $searched)"/>
                    <xsl:choose>
                        <xsl:when test="string-length($rec) = 0">
                            <xsl:value-of select="$before"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($before, $searched, $rec)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$toReturn"/>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>Shorthand to compare two strings and return a boolean</xd:desc>
    </xd:doc>
    <xsl:function name="func:string-compare" as="xs:boolean">
        <xsl:param name="stringA"/>
        <xsl:param name="stringB"/>
        <xsl:variable name="compResult">
            <xsl:value-of select="compare(string($stringA),string($stringB))=0"/>
            <!--<xsl:choose>
                <xsl:when test="">
                    
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="compare(string($stringA),string($stringB))=0"/>
                </xsl:otherwise>
            </xsl:choose>-->
        </xsl:variable>
        <xsl:value-of select="$compResult"/>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>Get the substring after the last occurence of the given substring </xd:desc>
    </xd:doc>
    <xsl:function name="func:substring-after-last" as="xs:string">
        <xsl:param name="string"/>
        <xsl:param name="searched"/>
        <xsl:variable name="toReturn">
            <xsl:choose>
                <xsl:when test="contains($string, $searched)">
                    <xsl:variable name="after"
                        select="substring-after($string, $searched)"/>
                    
                    <xsl:variable name="rec" 
                        select="func:substring-after-last($after, $searched)"/>
                    <xsl:choose>
                        <xsl:when test="string-length($rec) = 0">
                            <xsl:value-of select="$after"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$rec"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$toReturn"/>
    </xsl:function>
    
    
    <xd:doc>
        <xd:desc>Returns the main schema, the schema with 'main' type.</xd:desc>
    </xd:doc>
    <xsl:function name="func:getMainResource" as="item()">
        <xsl:value-of select="$documentationRoot/schema[@type='main']"/>
    </xsl:function>
    
    
    
    <xd:doc>
        <xd:desc>The entry point </xd:desc>
    </xd:doc>
    <xsl:template match="schemaDoc">
        
        
        <reference>
            <xsl:attribute name="id">
                <xsl:value-of select="$rootID"/>
            </xsl:attribute>
                <title>
                    <xsl:value-of select="func:getTitleFromSplitInfo(splitInfo)"/>
                </title>
            <xsl:call-template name="main"/>
        </reference>
    </xsl:template>

    <xd:doc>
        <xd:desc>Create the a link element to a component</xd:desc>
    </xd:doc>
    <xsl:template name="reference">
        <xsl:param name="ref" select="."/>
        <xsl:variable name="refID">
            <xsl:choose>
                <xsl:when test="exists($ref/@refId)">
                    <xsl:value-of select="$ref/@refId"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>noID</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="refType">
            <xsl:choose>
                <xsl:when test="exists($ref/@refType)">
                    <xsl:value-of select="$ref/@refType"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>noType</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="func:string-compare($refType,'Attribute')">
                <option>
                    <xsl:value-of select="func:refTextOnly($ref/text())"/>
                    <xsl:value-of select="func:refTextQualifier($ref/text())"/>
                </option>
            </xsl:when>
            <xsl:when test="func:string-compare($refType,'Element')">
                <keyword keyref="{concat($ref/@refType,'-',$ref/@refId)}">
                    <xsl:value-of select="func:refTextOnly($ref/text())"/>
                </keyword>
                <xsl:value-of select="func:refTextQualifier($ref/text())"/>
            </xsl:when>
            <xsl:when test="func:string-compare($refID,'noID')">
                <ph>
                    <xsl:value-of select="func:refTextOnly($ref/text())"/>
                    <xsl:value-of select="func:refTextQualifier($ref/text())"/>
                </ph>
            </xsl:when>
            <xsl:otherwise>
                <ph>
                    <xsl:comment>
                        <xsl:value-of select="concat($ref/@refType,'-',$ref/@refId)"/>
                    </xsl:comment>
                    <xsl:value-of select="func:refTextOnly($ref/text())"/>
                    <xsl:value-of select="func:refTextQualifier($ref/text())"/>
                </ph>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:function name="func:refTextOnly" as="xs:string">
        <xsl:param name="reftext"/>
        <xsl:value-of select="replace($reftext,$refCountSpecifiers,'')"></xsl:value-of>
    </xsl:function>
    
    <xsl:function name="func:refTextQualifier" as="xs:string">
        <xsl:param name="reftext"/>
        <xsl:variable name="qualifier">
            <xsl:choose>
                <xsl:when test="not(matches($reftext,$refCountSpecifiers))">
                    <xsl:text></xsl:text>
                </xsl:when>
                <xsl:when test="matches($reftext,'\*$')">
                    <xsl:text> (any number)</xsl:text>
                </xsl:when>
                <xsl:when test="matches($reftext,'\{0,1\}$')">
                    <xsl:text> (optional)</xsl:text>
                </xsl:when>
                <xsl:when test="matches($reftext,'\+$')">
                    <xsl:text> (one or more)</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$qualifier"/>
    </xsl:function>

    <xd:doc>
        <xd:desc>Generates the index part.</xd:desc>
        <xd:param name="mode">
            One of:
            <xd:ul>
                <xd:li><xd:b>namespace</xd:b> to indicate it must generate a grouping by namespace</xd:li>
                <xd:li><xd:b>location</xd:b> to indicate it must generate a grouping by location</xd:li>
                <xd:li><xd:b>component</xd:b> to indicate it must generate a grouping by component</xd:li>
                <xd:li><xd:b>schHierarchy</xd:b> to indicate it must generate schema hierarchy</xd:li>
            </xd:ul>
        </xd:param>
        <xd:param name="outputFile">File where to redirect the index.</xd:param>
        <xd:param name="hasHierarchy">true if a hierarchy of the schemas will also be presented.</xd:param>
    </xd:doc>
    <xsl:template name="index">
        <xsl:param name="mode"/>
        <xsl:param name="outputFile"/>
        <xsl:param name="hasHierarchy" as="xs:boolean">true</xsl:param>        
        <xsl:result-document href="{$outputFile}" method="xml" indent="yes"
            doctype-public="-//OASIS//DTD DITA Reference//EN"
            doctype-system="reference.dtd" 
            exclude-result-prefixes="#all" >
            <reference>
                <head>
                    <title>
                        <xsl:value-of select="func:getTitleFromSplitInfo(splitInfo)"/>
                    </title>
                    
                    
                </head>
                <body>
                    
                    <!--<xsl:call-template name="indexContent">
                        <xsl:with-param name="mode" select="$mode"/>
                        <xsl:with-param name="hasHierarchy" select="$hasHierarchy"/>
                    </xsl:call-template>-->
                    
                    <xsl:if test="string-length($outputFile) > 0">
                        <!-- If we are redirecting to a different file we must also include the footer. -->
                        <xsl:call-template name="generateFooter"/>
                    </xsl:if>
                </body>
            </reference>
        </xsl:result-document>
    </xsl:template>

    <xsl:function name="func:getIndexFile" as="xs:string">
        <xsl:param name="mode"></xsl:param>
            <xsl:choose>
            <xsl:when test="$mode = 'location'">
                <xsl:value-of select="$indexFile"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$mode = 'namespace'">
                        <xsl:value-of select="$indexFileNamespace"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="$mode = 'schHierarchy'">
                                <xsl:value-of select="$schemaHierarchyFile"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$indexFileComp"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <!--<xsl:template name="indexContent">
        <xsl:param name="mode"/>
        <xsl:param name="hasHierarchy" as="xs:boolean">true</xsl:param>
        <h2>
            <a id="INDEX">Table of Contents</a>
        </h2>
        <xsl:if test="$hasHierarchy">
            <p>
                <a href="{func:getIndexFile('location')}">Components</a>
                <span> | </span>
                <a href="{$schemaHierarchyFile}">Resource Hierarchy</a>
            </p>
            <hr/>
        </xsl:if>
        <xsl:if test="$mode != 'schHierarchy'">
        <div class="toc">
            <form action="none">
                <div>
                    <span> Group by: <select id="selectTOC"
                        onchange="selectTOCGroupBy(this.options[this.selectedIndex].value, {$isChunkMode}, '{func:getIndexFile('location')}', '{func:getIndexFile('namespace')}', '{func:getIndexFile('component')}');">
                        
                        <xsl:element name="option">
                            <xsl:attribute name="value">toc_group_by_namespace</xsl:attribute>
                            <xsl:if test="not($isChunkMode) or $mode = 'namespace'">
                                <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                            <xsl:text>Namespace</xsl:text>
                        </xsl:element>
                        <xsl:element name="option">
                            <xsl:attribute name="value">toc_group_by_location</xsl:attribute>
                            <xsl:if test="$isChunkMode and $mode = 'location'">
                                <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                            <xsl:text>Location</xsl:text>
                        </xsl:element>
                        <xsl:element name="option">
                            <xsl:attribute name="value">toc_group_by_component_type</xsl:attribute>
                            <xsl:if test="$isChunkMode and $mode = 'component'">
                                <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                            <xsl:text>Component Type</xsl:text>
                        </xsl:element>

                        </select>
                    </span>
                </div>
            </form>

            <!-\- Generate links grouped by the namespace of the component-\->
            <xsl:if test="not($isChunkMode) or $mode = 'namespace'">

                <xsl:variable name="boxId">groupByNs</xsl:variable>
                <div class="level1" id="toc_group_by_namespace" style="display:block">
                    <!-\- This is the displayed div by default if there is no chunking or it is chunked by namespace -\->
                    <div>
                        <xsl:for-each-group select="ref" group-by="@ns">
                            <xsl:variable name="ns">
                                <xsl:choose>
                                    <xsl:when test="compare('', @ns) = 0">No namespace</xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="@ns"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:variable name="nsBoxId">boxIdNamespace<xsl:value-of
                                    select="position()"/></xsl:variable>
                            <div class="level2">
                                <p>
                                    <input id="button_{$nsBoxId}" type="image" value="-"
                                        src="img/btM.gif"
                                        onclick="switchState('{$nsBoxId}');" class="control"/>
                                    <span class="indexGroupTitle">
                                        <xsl:value-of select="$ns"/>
                                    </span>
                                </p>
                                <div id="{$nsBoxId}" style="display:block">                                    
                                    <xsl:call-template name="indexGroupByComponent">
                                        <xsl:with-param name="refSeq" select="current-group()"/>
                                        <xsl:with-param name="prefix" select="$nsBoxId"/>
                                    </xsl:call-template>
                                </div>
                            </div>
                        </xsl:for-each-group>
                    </div>
                </div>

            </xsl:if>
            
            <xsl:if test="not($isChunkMode) or $mode = 'component'">
                <!-\- Generate links grouped by the type of the component-\->
                <!-\- This is hidden by default. -\->
                <xsl:variable name="boxId">groupByCType</xsl:variable>
                <div class="level1" id="toc_group_by_component_type">
                    <!-\- This is the displayed div by default if there is chunking by component -\->
                    <xsl:choose>
                        <xsl:when
                            test="not($isChunkMode)">
                            <xsl:attribute name="style" select="'display:none'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="style" select="'display:block'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <div>
                        <xsl:call-template name="indexGroupByComponent">
                            <xsl:with-param name="refSeq" select="ref"/>
                        </xsl:call-template>
                    </div>
                </div>

            </xsl:if>

            <xsl:if test="not($isChunkMode) or $mode = 'location'">

                <!-\- Generate links grouped by the location of the component-\->
                <!-\- This is hidden by default. -\->
                <xsl:variable name="boxId">groupByLocation</xsl:variable>
                <div class="level1" id="toc_group_by_location">
                    <!-\- This is the displayed div by default if there is chunking by namespace -\->
                    <xsl:choose>
                        <xsl:when
                            test="not($isChunkMode)">
                            <xsl:attribute name="style" select="'display:none'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="style" select="'display:block'"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <div>
                        <xsl:for-each-group select="ref" group-by="@schemaLocation">
                            <xsl:variable name="schemaLocation">
                                <xsl:choose>
                                    <xsl:when test="compare('', @schemaLocation) = 0"/>
                                    <xsl:otherwise>
                                        <xsl:value-of select="@schemaLocation"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:variable name="locationBoxId" select="concat('gr_',$schemaLocation)"/>
                            <div class="level2">
                                <p>
                                    <input id="button_{$locationBoxId}" type="image" value="-"
                                        src="img/btM.gif"
                                        onclick="switchState('{$locationBoxId}');" class="control"/>
                                    <span class="indexGroupTitle">
                                        <xsl:value-of select="$schemaLocation"/>
                                    </span>
                                </p>
                                <div id="{$locationBoxId}" style="display:block">
                                    <xsl:call-template name="indexGroupByComponent">
                                        <xsl:with-param name="refSeq" select="current-group()"/>
                                        <xsl:with-param name="prefix" select="$locationBoxId"/>
                                    </xsl:call-template>
                                </div>
                            </div>
                        </xsl:for-each-group>
                    </div>
                </div>

            </xsl:if>

        </div>
        </xsl:if>
        
        <!-\-<xsl:if test="$isChunkMode and $mode = 'schHierarchy'">            
            <xsl:if test="not(empty($resourceHierarchyNode))">
                <xsl:call-template name="buildSchemaHierarchy">
                    <xsl:with-param name="schemaHierarchy" select="$resourceHierarchyNode"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>-\->
    </xsl:template>-->

    <!--<xd:doc>
        <xd:desc>
            Generate index grouped by component type.
            Can be overridden in order to customize index generation.
        </xd:desc>
    </xd:doc>-->
    <!--<xsl:template name="indexGroupByComponent">
        <xsl:param name="refSeq" required="yes"/>
        <xsl:param name="prefix"/>
        <xsl:call-template name="generateComponentsIndex">
            <xsl:with-param name="refSeq" select="$refSeq"/>
            <xsl:with-param name="prefix" select="$prefix"/>
        </xsl:call-template>    
    </xsl:template>-->

	


    <xsl:template match="schema">
        <xsl:call-template name="component">
            <xsl:with-param name="type">
             <xsl:variable name="currentSchema" select="."/>
                <xsl:value-of select="$schemaTypeLabels/*[@key=$currentSchema/@type]"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="element">        
        <xsl:call-template name="component">
            <xsl:with-param name="type">Element</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="complexType">
        <xsl:call-template name="component">
            <xsl:with-param name="type">Complex Type</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="simpleType">
        <xsl:call-template name="component">
            <xsl:with-param name="type">Simple Type</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="attribute">
        <xsl:call-template name="component">
            <xsl:with-param name="type">Attribute</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="attributeGroup">
        <xsl:call-template name="component">
            <xsl:with-param name="type">Attribute Group</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="elementGroup">
        <xsl:call-template name="component">
            <xsl:with-param name="type">Element Group</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="notation">
        <xsl:call-template name="component">
            <xsl:with-param name="type">Notation</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:function name="func:createControl" as="item()">
        <xsl:param name="boxID"/>
        <xsl:param name="buttonID"/>
        <input id="{$buttonID}" type="image" src="img/btM.gif" value="-" onclick="switchState('{$boxID}');"
            class="control"/>
    </xsl:function>

    <xsl:template match="facets">
        <xsl:variable name="boxID" select="func:getDivId(.)"/>
        <tr>
            <td class="firstColumn">
                <div class="floatLeft">
                    <b>Facets</b>
                </div>
                <div class="floatRight">
                    <xsl:copy-of select="func:createControl($boxID, func:getButtonId(.))"/>                    
                </div>
            </td>
            <td>
                <div id="{$boxID}" style="display:block">
                    <table class="facetsTable">
                        <xsl:for-each select="./facet">
                            <tr>
                                <td class="firstColumn">
                                    <xsl:value-of select="@name"/>
                                </td>
                                <td width="30%">
                                    <b>
                                        <xsl:value-of select="@value"/>
                                    </b>
                                </td>
                                <td>
                                    <div class="annotation">
                                        <xsl:for-each select="annotation">
                                            <xsl:call-template name="buildAnnotation"/>                                        
                                        </xsl:for-each>
                                    </div>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </div>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="defaultOpenContent">
        <xsl:variable name="boxID" select="func:getDivId(.)"/>
        <tr>
            <td class="firstColumn">
                <div class="floatLeft">
                    <b>Default Open Content</b>
                </div>
                <div class="floatRight">
                    <xsl:copy-of select="func:createControl($boxID, func:getButtonId(.))"/>                    
                </div>
            </td>
            <td>
                <div id="{$boxID}" style="display:block">
                    <table class="propertiesTable">
                        <!-- Add open content documentation -->
                        <xsl:if test="exists(@mode)">
                            <tr>
                                <td class="firstColumn">Mode</td>
                                <td>
                                    <xsl:value-of select="@mode"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="exists(text())">
                            <tr>
                                <td class="firstColumn">Wildcard</td>
                                <td>
                                    <xsl:value-of select="text()"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="exists(@processContents)">
                            <tr>
                                <td class="firstColumn">Process contents</td>
                                <td>
                                    <xsl:value-of select="@processContents"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="exists(@appliesToEmpty)">
                            <tr>
                                <td class="firstColumn">Applies to empty</td>
                                <td>
                                    <xsl:value-of select="@appliesToEmpty"/>
                                </td>
                            </tr>
                        </xsl:if>
                    </table>
                </div>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="properties">
        <xsl:for-each select="./property">
            <xsl:comment>
                <xsl:value-of select="name"/>
                <xsl:text>:</xsl:text>
                <xsl:value-of select="value"/>
            </xsl:comment>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="*:namespace">
        <tr>
            <td class="firstColumn">
                <b>Namespace</b>
            </td>
            <td>
                <xsl:choose>
                    <xsl:when test="compare('', text()) != 0">
                        <xsl:value-of select="text()"/>
                    </xsl:when>
                    <xsl:otherwise>No namespace</xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="schemaLocation">
        <tr>
            <td class="firstColumn">
                <b>Schema location</b>
            </td>
            <td>
                <xsl:value-of select="text()"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="diagram">
        <xsl:variable name="boxID" select="func:getDivId(.)"/>
        <tr>
            <td class="firstColumn">
                <div class="floatLeft"><b>Diagram</b></div>
                <div class="floatRight">
                    <xsl:copy-of select="func:createControl($boxID, func:getButtonId(.))"/>
                </div>
            </td>
            <td class="diagram">
                <div id="{$boxID}" style="display:block">
                    <xsl:variable name="hasMap" as="xs:boolean" select="count(map) != 0"/>
                    <xsl:variable name="diagramLoc" select="location/text()"/>
                    <xsl:variable name="isSvgImage" select="ends-with($diagramLoc, '.svg')"/>
                    <xsl:choose>
                        <xsl:when test="$isSvgImage">
                            <xsl:element name="object">
                                <xsl:attribute name="border">0</xsl:attribute>
                                <xsl:attribute name="data">
                                    <xsl:value-of select="$diagramLoc"></xsl:value-of>
                                </xsl:attribute>
                                <xsl:attribute name="type">image/svg+xml</xsl:attribute>
                            </xsl:element> 
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="img">
                                <xsl:attribute name="alt">Diagram</xsl:attribute>
                                <xsl:attribute name="border">0</xsl:attribute>
                                <xsl:attribute name="src">
                                    <xsl:value-of select="$diagramLoc"></xsl:value-of>
                                </xsl:attribute>
                                <xsl:if test="boolean($hasMap)">
                                    <xsl:attribute name="usemap">
                                        <xsl:value-of select="concat('#', map/@name)"></xsl:value-of>
                                    </xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            <xsl:if test="boolean($hasMap)">
                                <xsl:variable name="mapName" select="map/@name"/>
                                <map name='{$mapName}' id='{$mapName}'>
                                    <xsl:for-each select="map/area">
                                        <area alt="{@alt}" href="{replace(@href, concat($intermediateXmlExtension, '#'), concat($extension, '#'))}" coords="{@coords}"/>
                                    </xsl:for-each>
                                </map>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>    
                </div>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="usedBy">
        <xsl:variable name="allRefsAreComplex" as="xs:boolean">
            <xsl:value-of select="(count(ref) = count(ref[@refType='Complex_Type']))"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="not($allRefsAreComplex)">
                <xsl:for-each-group select="ref" group-by="@refType">
                    <xsl:if test="not(func:string-compare(./@refType,'Complex_Type'))">
                        <section>
                            <title>Allowed In</title>
                            <p>
                                <xsl:for-each select="current-group()">
                                    <xsl:sort select="text()"/>
                                    <xsl:call-template name="reference"/>
                                    <xsl:if test="position() != last()">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            </p>
                        </section>
                    </xsl:if>
                </xsl:for-each-group>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="usedByImplied">
                    <xsl:with-param name="thisId" select="parent::node()/@id"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="usedByImplied">
        <xsl:param name="thisId"/>
        <section>
            <title>Allowed In</title>
            <p><xsl:comment>implied by reference to <xsl:value-of select="$thisId"/></xsl:comment>
                <xsl:for-each select="key('elementUsesID',$thisId)">
                    <xsl:sort select="qname/text()"/>
                    <keyword keyref="{concat('Element-',@id)}">
                        <!-- Let keyref resolution provide text -->
                    </keyword>
                    <xsl:if test="position() != last()">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </p>
        </section>
    </xsl:template>

    <xsl:template match="attributes">
        <section>
            <title>Attributes</title>
            <xsl:if test="count(attr) > 0 or count(defaultAttr) > 0">
                <xsl:variable name="showFixed" select="exists(attr/fixed/text()) or exists(defaultAttr/fixed/text())" as="xs:boolean"/>
                <xsl:variable name="showDefault" select="exists(attr/default/text()) or exists(defaultAttr/default/text())" as="xs:boolean"/>
                <xsl:variable name="showUse" select="exists(attr/use/text()) or exists(defaultAttr/use/text())" as="xs:boolean"/>
                <xsl:variable name="showInheritable" select="exists(attr/inheritable/text()) or exists(defaultAttr/inheritable/text())" as="xs:boolean"/>
                <!--<xsl:variable name="showAnn" select="exists(attr/annotations) or exists(defaultAttr/annotations)" as="xs:boolean"/>-->
                <xsl:variable name="showAnn" select="exists(attr/annotations) or exists(defaultAttr/annotations)" as="xs:boolean"/>
                <simpletable relcolwidth="15* 55* 15* 15*">
                    <!--<thead>
                        <tr>
                            <th>QName</th>
                            <th width="10%">Type</th>
                            <xsl:if test="$showFixed">
                                <th width="5%">Fixed</th>
                            </xsl:if>
                            <xsl:if test="$showDefault">
                                <th width="10%">Default</th>
                            </xsl:if>
                            <xsl:if test="$showUse">
                                <th width="5%">Use</th>
                            </xsl:if>
                            <xsl:if test="$showInheritable">
                                <th width="5%">Inheritable</th>
                            </xsl:if>
                            <th>
                                <xsl:if test="$showAnn">Annotation</xsl:if>
                            </th>
                        </tr>
                    </thead>-->
                    <sthead>
                        <stentry>Attribute</stentry>
                        <stentry>Description</stentry>
                        <stentry>Data Type</stentry>
                        <stentry>Required</stentry>
                    </sthead>
                    
                    <xsl:for-each select="attr|defaultAttr">
                        <xsl:sort select="ref/text()"/>
                        <strow>
                            <stentry>
                                <xsl:call-template name="reference">
                                    <xsl:with-param name="ref" select="ref"/>
                                </xsl:call-template>
                            </stentry>
                            <stentry>
                                <xsl:attribute name="conkeyref">
                                    <xsl:value-of select="concat('Attribute-',ref/@refId,'/description')"/>
                                </xsl:attribute>
                                <xsl:attribute name="conref">
                                    <xsl:value-of select="concat('#',$rootID,'/undefined_description')"/>
                                </xsl:attribute>
                            </stentry>
                            <stentry>
                                <xsl:call-template name="typeEmitter">
                                    <xsl:with-param name="type" select="type"/>
                                </xsl:call-template>
                            </stentry>
                            <stentry>
                                <xsl:if test="$showUse">
                                    <xsl:value-of select="use"/>
                                </xsl:if>
                                <xsl:if test="$showDefault">
                                    <p>
                                        <xsl:text>(default value: </xsl:text>
                                        <keyword><xsl:value-of select="default"/></keyword>
                                        <xsl:text>)</xsl:text>
                                    </p>
                                </xsl:if>
                                <xsl:if test="$showFixed">
                                    <xsl:comment>
                                        <xsl:value-of select="fixed"/>
                                    </xsl:comment>
                                </xsl:if>
                                
                                <xsl:if test="$showInheritable">
                                    <xsl:comment>
                                        <xsl:value-of select="inheritable"/>
                                    </xsl:comment>
                                </xsl:if>
                            </stentry>
<!--                            <td>
                                <div class="annotation">
                                    <xsl:for-each select="annotations/annotation">
                                        <xsl:call-template name="buildAnnotation"/>
                                    </xsl:for-each>
                                </div>
                            </td>-->
                        </strow>
                    </xsl:for-each>
                    
                </simpletable>
                
            </xsl:if>
            
            <xsl:if test="count(anyAttr) > 0">
                <table>
                    <xsl:for-each select="anyAttr">
                        <tr>
                            <td width="100%">
                                <b>Wildcard:  </b>
                                <xsl:value-of select="text()"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </xsl:if>
                
            
        
        </section>
    </xsl:template>
    
    <xsl:template match="asserts">
        <xsl:variable name="boxID" select="func:getDivId(.)"/>
        <tr>
            <td class="firstColumn">
                <div class="floatLeft">
                    <b>Asserts</b>
                </div>
                <div class="floatRight">
                    <xsl:copy-of select="func:createControl($boxID, func:getButtonId(.))"/>
                </div>
            </td>
            <td>
                <div id="{$boxID}" style="display:block">
                    <table class="attributesTable">
                        <thead>
                            <tr>
                                <th>Test</th>
                                <th>XPath default namespace</th>
                                <th>Annotation</th>
                            </tr>
                        </thead>
                        <xsl:for-each select="assert">
                            <tr>
                                <td class="firstColumn">
                                    <xsl:value-of select="test"/>
                                </td>
                                <td width="10%">
                                    <xsl:value-of select="xpathDefaultNs"/>
                                </td>
                                <td width="10%">
                                    <div class="annotation">
                                        <xsl:for-each select="annotations/annotation">
                                            <xsl:call-template name="buildAnnotation"/>
                                        </xsl:for-each>
                                    </div>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </div>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="typeAlternatives">
        <xsl:variable name="boxID" select="func:getDivId(.)"/>
        <tr>
            <td class="firstColumn">
                <div class="floatLeft">
                    <b>Type Alternatives</b>
                </div>
                <div class="floatRight">
                    <xsl:copy-of select="func:createControl($boxID, func:getButtonId(.))"/>
                </div>
            </td>
            <td>
                <div id="{$boxID}" style="display:block">
                    <table class="attributesTable">
                        <thead>
                            <tr>
                                <th>Type</th>
                                <th>Test</th>
                                <th>XPath default namespace</th>
                                <th>Annotation</th>
                            </tr>
                        </thead>
                        <xsl:for-each select="typeAlternative">
                            <tr>
                                <td class="firstColumn">
                                    <xsl:call-template name="typeEmitter">
                                        <xsl:with-param name="type" select="type"/>
                                    </xsl:call-template>
                                    <!-- Last type is the default type alternative, if the test XPath expression is missing-->
                                    <xsl:if test="(position() = last()) and not(exists(test/text()))">
                                        <i>
                                            <xsl:text> [Default Type]</xsl:text>
                                        </i>
                                    </xsl:if>
                                </td>
                                <td width="15%">
                                    <xsl:value-of select="test"/>
                                </td>
                                <td width="15%">
                                    <xsl:value-of select="xPathDefaultNs"/>
                                </td>
                                <td width="15%">
                                    <div class="annotation">
                                        <xsl:for-each select="annotations/annotation">
                                            <xsl:call-template name="buildAnnotation"/>
                                        </xsl:for-each>
                                    </div>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </div>
            </td>
        </tr>
    </xsl:template>

    <xsl:template name="component">
        <xsl:param name="type"/>
        <refbodydiv>
            <xsl:choose>
                <xsl:when test="exists(redefinedComponent)">
                    <xsl:text>Redefines </xsl:text>
                    <xsl:value-of select="$type"/>
                    <xsl:text> </xsl:text>
                    <xsl:call-template name="reference">
                        <xsl:with-param name="ref" select="redefinedComponent"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="exists(overriddenComponent)">
                    <xsl:text>Overrides </xsl:text>
                    <xsl:value-of select="$type"/>
                    <xsl:text> </xsl:text>
                    <xsl:call-template name="reference">
                        <xsl:with-param name="ref" select="overriddenComponent"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="exists(overridingComponent)">
                    <xsl:text>Overridden by </xsl:text>
                    <xsl:value-of select="$type"/>
                    <xsl:text> </xsl:text>
                    <xsl:call-template name="reference">
                        <xsl:with-param name="ref" select="overridingComponent"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="id" select="concat(replace($type,' ','-'),'-',@id)"/>
                    <!--<xsl:comment>
                        
                        <xsl:value-of select="$type"/>
                        <xsl:text> </xsl:text>
                        
                        <xsl:for-each select="declarationPath/ref">
                            <xsl:call-template name="reference"/>
                            <xsl:text> / </xsl:text>
                        </xsl:for-each>
                        <xsl:if test="compare(local-name(.), 'attribute') = 0">
                            <xsl:text>@</xsl:text>
                        </xsl:if>
                        <xsl:value-of select="*:qname/text()"/>
                    </xsl:comment>-->
                    
                </xsl:otherwise>
            </xsl:choose>
        <xsl:call-template name="generateComponentDocumentation"/>
        </refbodydiv>

        
        
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Generate documentation for a component.</xd:desc>
    </xd:doc>
    <xsl:template name="generateComponentDocumentation">
        <xsl:apply-templates select="namespace | annotations"/>
        <xsl:apply-templates select="diagram | type | typeHierarchy | typeAlternatives | properties | defaultOpenContent"/>
        <xsl:apply-templates select="facets"/>
        <xsl:apply-templates select="substitutionGroup | substitutionGroupAffiliation"/>
        <xsl:if test="not(exists(usedBy))">
            <xsl:call-template name="usedByImplied">
                <xsl:with-param name="thisId" select="./@id"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:apply-templates select="usedBy | model | children | attributes | asserts | contraints | instance | source"/>
        <xsl:apply-templates select="publicid | systemid"/>
        <xsl:apply-templates select="schemaLocation"/>
    </xsl:template>

    <xsl:template name="typeEmitter">
        <xsl:param name="type"/>
        <xsl:for-each select="$type/node()">
            <xsl:choose>
                <xsl:when test="compare('ref', local-name()) = 0">
                    <xsl:call-template name="reference">
                        <xsl:with-param name="ref" select="."/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="element/type | complexType/type | attribute/type | simpleType/type">
        <tr>
            <td class="firstColumn">
                <b>Type</b>
            </td>
            <td>
                <xsl:call-template name="typeEmitter">
                    <xsl:with-param name="type" select="."/>
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>

    <xd:doc>
        <xd:desc>Show the hierarchy type  </xd:desc>
    </xd:doc>
    <xsl:template name="hierarchyOutput">
        <xsl:param name="refs"/>
        <xsl:param name="index" as="xs:integer" select="1"/>
        <ul>
            <li>
                <xsl:call-template name="reference">
                    <xsl:with-param name="ref" select="$refs[$index]"/>
                </xsl:call-template>

                <xsl:if test="$index &lt; count($refs)">
                    <xsl:call-template name="hierarchyOutput">
                        <xsl:with-param name="refs" select="$refs"/>
                        <xsl:with-param name="index" select="$index + 1"/>
                    </xsl:call-template>
                </xsl:if>
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="typeHierarchy">
        <tr>
            <td class="firstColumn">
                <b>Type hierarchy</b>
            </td>
            <td>
                <xsl:call-template name="hierarchyOutput">
                    <xsl:with-param name="refs" select="ref"/>
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="model">
        <section>
        <title>Content Model</title>
        <p>
            <!-- Add a table only if we have an open content to display in the model. --> 
            <xsl:choose>
                <xsl:when test="exists(openContent)">
                    <table>
                        <xsl:if test="count(group) > 0">
                            <tr>
                                <td colspan="2">
                                    <xsl:call-template name="groupTemplate">
                                        <xsl:with-param name="group" select="group[1]"/>
                                    </xsl:call-template>
                                </td>
                            </tr>
                        </xsl:if>
                        <!-- Add open content documentation -->
                        <xsl:if test="exists(openContent)">
                            <xsl:choose>
                                <xsl:when test="exists(openContent/ref)">
                                    <!-- Add rederence to default open content -->
                                    <tr>
                                        <td colspan="2">
                                            <xsl:call-template name="reference">
                                                <xsl:with-param name="ref" select="openContent/ref"/>
                                            </xsl:call-template>
                                        </td>
                                    </tr>
                                </xsl:when>
                                
                                <xsl:otherwise>
                                    <!-- Add open content information. -->
                                    <tr>
                                        <td colspan="2">
                                            <b>Open Content:</b>
                                        </td>
                                    </tr>
                                    <xsl:if test="exists(openContent/@mode)">
                                        <tr>
                                            <td class="firstColumn">Mode</td>
                                            <td>
                                                <xsl:value-of select="openContent/@mode"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="exists(openContent/text())">
                                        <tr>
                                            <td class="firstColumn">Wildcard</td>
                                            <td>
                                                <xsl:value-of select="openContent/text()"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="exists(openContent/@processContents)">
                                        <tr>
                                            <td class="firstColumn">Process contents</td>
                                            <td>
                                                <xsl:value-of select="openContent/@processContents"
                                                />
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="exists(openContent/@appliesToEmpty)">
                                        <tr>
                                            <td class="firstColumn">Applies to empty</td>
                                            <td>
                                                <xsl:value-of select="openContent/@appliesToEmpty"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="groupTemplate">
                        <xsl:with-param name="group" select="group[1]"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </p>
        </section>
    </xsl:template>

    <xsl:template name="groupTemplate">
        <xsl:param name="group" select="."/>
        <xsl:variable name="compositor">
            <xsl:value-of select="$group/@compositor"/>
        </xsl:variable>
        <xsl:variable name="separator">
            <xsl:if test="compare($compositor, 'sequence') = 0">
                <xsl:text>, then </xsl:text>
            </xsl:if>
            <xsl:if test="compare($compositor, 'choice') = 0">
                <xsl:text> or </xsl:text>
            </xsl:if>
            <xsl:if test="compare($compositor, 'all') = 0">
                <xsl:text> or </xsl:text>
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="isMixed" as="xs:boolean">
            <xsl:value-of select="boolean(ancestor::element/properties/property[contains(name/text(),'mixed')][contains(value/text(),'true')])"/>
        </xsl:variable>
        
        <xsl:if test="not($group/*) and $isMixed">
            <xsl:text>text</xsl:text>
        </xsl:if>

        <xsl:if test="compare($compositor, 'all') = 0">
            <xsl:text>any of (</xsl:text>
            <xsl:if test="$isMixed">
                <xsl:text>text or </xsl:text>
            </xsl:if>
        </xsl:if>
        
        <xsl:for-each
            select="$group/*[compare(local-name(.), 'group') = 0 or compare(local-name(.), 'ref') = 0]">
            <xsl:if test="position() != 1">
                <xsl:value-of select="$separator"/>
            </xsl:if>
            <xsl:choose>
                <!--<xsl:when test="compare(local-name(.), 'ref') = 0 and compare(./@refType, 'Complex_Type') = 0">
                    <!-\- ALREADY HANDLED BY DEFAULT PROCESSING? -\->
                    <!-\- Substitute the content model for the referenced complex type. -\->
                    <xsl:variable name="complexTypeID">
                        <xsl:value-of select="./@refId"/>
                    </xsl:variable>
                    <xsl:comment>Content model for complex type <xsl:value-of select="$complexTypeID"/></xsl:comment>
                    <xsl:call-template name="groupTemplate">
                        <xsl:with-param name="group" 
                            select="//complexType[@id='$complexTypeID']/model/group[1]"/>
                        <!-\- there will always be 0 or 1 top-level group element -\->
                    </xsl:call-template>
                </xsl:when>-->
                <xsl:when test="compare(local-name(.), 'ref') = 0">
                    <xsl:call-template name="reference"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="nextCompositor">
                        <xsl:value-of select="@compositor"/>
                    </xsl:variable>

                    <xsl:if test="compare($compositor, $nextCompositor) != 0">
                        <xsl:text>(</xsl:text>
                        <xsl:if test="$isMixed">
                            <xsl:text>text or </xsl:text>
                        </xsl:if>
                    </xsl:if>

                    <xsl:call-template name="groupTemplate"/>

                    <xsl:if test="compare($compositor, $nextCompositor) != 0">
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>

        <xsl:if test="compare($compositor, 'all') = 0">
            <xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="children">
        <tr>
            <td class="firstColumn">
                <b>Children</b>
            </td>
            <td>
                <xsl:for-each select="child">
                    <xsl:sort select="ref/text()"/>
                    <xsl:call-template name="reference">
                        <xsl:with-param name="ref" select="ref"/>
                    </xsl:call-template>
                    <xsl:if test="position() != last()">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="source | instance">
        <xsl:variable name="boxID" select="func:getDivId(.)"/>
        <tr>
            <td class="firstColumn">
                <div class="floatLeft">
                    <b>
                        <xsl:choose>
                            <xsl:when test="compare(local-name(.), 'source') = 0">Source</xsl:when>
                            <xsl:otherwise>Instance</xsl:otherwise>
                        </xsl:choose>
                     </b>
                </div>
                <div class="floatRight">
                    <xsl:copy-of select="func:createControl($boxID, func:getButtonId(.))"/>
                </div>
            </td>
            <td>
                <div id="{$boxID}" style="display:block">
                    <!-- Formats an XML source section-->
                    <xsl:variable name="tokens" select="token"/>
                    <xsl:call-template name="formatXmlSource">
                        <xsl:with-param name="tokens" select="$tokens"/>
                    </xsl:call-template>
                </div>
            </td>
        </tr>
    </xsl:template>


    <xsl:template match="constraints">
        <xsl:variable name="boxID" select="func:getDivId(.)"/>
        <tr>
            <td class="firstColumn">
                <div class="floatLeft">
                    <b>Identity constraints</b>
                </div>
                <div class="floatRight">
                    <xsl:copy-of select="func:createControl($boxID, func:getButtonId(.))"/>
                </div>
            </td>
            <td>
                <div id="{$boxID}" style="display:block">
                    <table class="identityConstraintsTable">
                        <thead>
                            <tr>
                                <th>QName</th>
                                <th>Type</th>
                                <th>Refer</th>
                                <th>Selector</th>
                                <th>Field(s)</th>
                            </tr>
                        </thead>
                        <xsl:for-each select="constraint">
                            <tr>
                                <td>
                                    <xsl:value-of select="name"/>
                                </td>
                                <td>
                                    <xsl:value-of select="type"/>
                                </td>
                                <td>
                                    <xsl:value-of select="refer"/>
                                </td>
                                <td>
                                    <xsl:value-of select="selector"/>
                                </td>
                                <td>
                                    <xsl:value-of select="fields"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </div>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="publicid | systemid">
        <tr>
            <td class="firstColumn">
                <b>
                    <xsl:choose>
                        <xsl:when test="compare(local-name(.), 'publicid') = 0"
                            >Public ID</xsl:when>
                        <xsl:otherwise>System ID</xsl:otherwise>
                    </xsl:choose>
                </b>
            </td>
            <td><xsl:value-of select="text()"/></td>
        </tr>
    </xsl:template>

    <xsl:template match="substitutionGroup | substitutionGroupAffiliation">
        <tr>
            <td class="firstColumn">
                <b>
                    <xsl:choose>
                        <xsl:when test="compare(local-name(.), 'substitutionGroup') = 0"
                            >Substitution Group</xsl:when>
                        <xsl:otherwise>Substitution Group Affiliation</xsl:otherwise>
                    </xsl:choose>
                </b>
            </td>
            <td>
                <ul>
                    <xsl:for-each select="ref">
                        <li>
                            <xsl:call-template name="reference"/>
                        </li>
                    </xsl:for-each>
                </ul>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="annotations">
        <xsl:variable name="boxID" select="func:getDivId(.)"/>
        <tr>
            <td class="firstColumn">
                <div class="floatLeft"><b>Annotations</b></div>
                <div class="floatRight">
                    <xsl:copy-of select="func:createControl($boxID, func:getButtonId(.))"/>
                </div>
            </td>
            <td>
                <div id="{$boxID}" style="display:block">
                    <xsl:for-each select="annotation">
                        <div class="annotation">
                            <xsl:call-template name="buildAnnotation"/>
                        </div>
                    </xsl:for-each>
                </div>
            </td>
        </tr>
    </xsl:template>

    <xd:doc>
        <xd:desc>Builds an annotation representation from the context annotation </xd:desc>
    </xd:doc>
    <xsl:template name="buildAnnotation">
        <xsl:if test="exists(@source)">
                <p><a href="{@source}"><xsl:value-of select="@source"/></a></p>
        </xsl:if>
        <xsl:variable name="tokens" select="token"/>
        <xsl:choose>
            <xsl:when test="empty($tokens)">
                <xsl:for-each select="child::node()">
                    <xsl:copy-of select="." copy-namespaces="no"/>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <!-- Formats an XML source section-->
                <xsl:call-template name="formatXmlSource">
                    <xsl:with-param name="tokens" select="$tokens"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="formatXmlSource">
        <xsl:param name="tokens"/>

        <table
            style="table-layout:fixed;white-space:pre-wrap;white-space:-moz-pre-wrap;white-space:-pre-wrap;white-space: -o-pre-wrap;word-wrap: break-word;_white-space:pre;"
            class="preWrapContainer">
            <tr>
                <td width="100%">
                    <pre>
                        <xsl:for-each select="$tokens">
                            <!-- The content of the token is space preserve -->
                            <xsl:element name="span">
                                <xsl:attribute name="class" select="@type"/>
                                <!-- On IE the pre-wrap does not normalize the text. Doing it here. -->
                                <xsl:choose>
                                    <xsl:when test="@type = 'tT'">
                                        <xsl:choose>
                                            <xsl:when test="text() = ' '">
                                                <!-- Just a whitespace should preserve it, 
                                                    may be it dellimits something.  -->
                                                <xsl:text xml:space="preserve"> </xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:choose>
                                                    <xsl:when test="@xml:space = 'preserve'">
                                                        <xsl:value-of select="text()"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <!-- Because we normalize there is no need to keep the whitespace preserve -->
                                                        <xsl:attribute name="style">white-space:normal</xsl:attribute>
                                                        <xsl:value-of select="normalize-space(text())"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:otherwise>
                                        </xsl:choose>                                        
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="text()"/>
                                    </xsl:otherwise>
                                </xsl:choose>                    
                            </xsl:element>
                        </xsl:for-each>
                    </pre>
                </td>
            </tr>
        </table>
    </xsl:template>

    
    <xd:doc>
        <xd:desc>The name of the option used to show/hide the annotations from the documentation</xd:desc>
    </xd:doc>
    <xsl:variable name="docOptionName">Annotations</xsl:variable>
    
    
    
    
    
    
    
    
    

    <xd:doc>
        <xd:desc>Check if there is any checkbox button that should be displayed for the current documentation.</xd:desc>
    </xd:doc>
    <xsl:variable name="areComponentsDetailsVisible" as="xs:boolean" select="$areSchemaComponentsDetailsVisible"/>
    
    <xd:doc>
        <xd:desc>Check if there is any schema component detail visible for the current documentation.</xd:desc>
    </xd:doc>
    <xsl:variable name="areSchemaComponentsDetailsVisible" as="xs:boolean" 
        select="boolean(string-length($annotationBoxes) > 0 
        or string-length($attributesBoxes) > 0
        or string-length($assertsBoxes) > 0
        or string-length($typeAlternativesBoxes) > 0
        or string-length($diagramBoxes) > 0 
        or string-length($facetsBoxes) > 0 
        or string-length($identityConstraintsBoxes) > 0 
        or string-length($instanceBoxes) > 0 
        or string-length($propertiesBoxes) > 0
        or string-length($modelBoxes) > 0 
        or string-length($defaultOpenContentBoxes) > 0 
        or string-length($sourceBoxes) > 0 
        or string-length($usedByBoxes) > 0)">
    </xsl:variable>

    <xsl:template name="main">
        <refbody>
            
            
            <xsl:variable name="hasSchemasHierarchy" select="not(empty($resourceHierarchyNode))"/>
            
            <!--<xsl:for-each select="index">
                <xsl:call-template name="indexContent">
                    <xsl:with-param name="mode">location</xsl:with-param>
                    <xsl:with-param name="hasHierarchy" select="$isChunkMode and $hasSchemasHierarchy"/>
                </xsl:call-template>
                <xsl:call-template name="index">
                    <xsl:with-param name="mode">namespace</xsl:with-param>
                    <xsl:with-param name="outputFile" select="$indexFileNamespace"/>
                    <xsl:with-param name="hasHierarchy" select="$isChunkMode and $hasSchemasHierarchy"/>
                </xsl:call-template>
                <xsl:call-template name="index">
                    <xsl:with-param name="mode">component</xsl:with-param>
                    <xsl:with-param name="outputFile" select="$indexFileComp"/>
                    <xsl:with-param name="hasHierarchy" select="$isChunkMode and $hasSchemasHierarchy"/>
                </xsl:call-template>
            </xsl:for-each>-->
            
            
            <xsl:if test="not($isChunkMode) and $hasSchemasHierarchy">
                <xsl:call-template name="buildSchemaHierarchy">
                    <xsl:with-param name="schemaHierarchy" select="$resourceHierarchyNode"/>
                    <xsl:with-param name="title">Resource hierarchy:</xsl:with-param>
                </xsl:call-template>
            </xsl:if>
            
            <refbodydiv>
                <simpletable>
                    <strow>
                        <stentry id="undefined_description">
                            <xsl:comment>attribute description not found</xsl:comment>
                        </stentry>
                    </strow>
                </simpletable>
            </refbodydiv>
            
            
            
            <!-- Process root children to generate documentation for XML Schema components-->
            <xsl:call-template name="processDocumentationElements"/>
            
            <xsl:call-template name="generateFooter"/>

            
        </refbody>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Apply templates to generate documentation for XML Schema components</xd:desc>
    </xd:doc>
    <xsl:template name="processDocumentationElements">
        <xsl:apply-templates select="element | complexType | attribute | simpleType | elementGroup | schema | attributeGroup | notation"/>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>The name of the documentation</xd:desc>
    </xd:doc>
    <xsl:variable name="documentationName">XML Schema documentation</xsl:variable>
    
    <xd:doc>
        <xd:desc>Generate the footer that must appear in all files.</xd:desc>
    </xd:doc>
    <xsl:template name="generateFooter"></xsl:template>

    <xd:doc>
        <xd:desc>Builds a hierarchy of the documented schemas based on the detected directives.</xd:desc>
        <xd:param name="mainSchema">Main schema. The hierarchy is found inside it.</xd:param>
    </xd:doc>
    <xsl:template name="buildSchemaHierarchy">
        <xsl:param name="schemaHierarchy"/>
        <xsl:param name="title"/>
            <xsl:if test="not(empty($schemaHierarchy))">
                <xsl:if test="$title != ''">
                    <p class="sHierarchyTitle"><xsl:value-of select="$title"/></p>
                </xsl:if>
                <ul class="schemaHierarchy">
                    <li>
                        <xsl:variable name="uniqueId" select="concat('sH', $schemaHierarchy/@refId)"/>
                        <p class="componentTitle">
                            <input id="button_{$uniqueId}" type="image" value="-"
                                src="img/btM.gif"
                                onclick="switchState('{$uniqueId}');" class="control"/>
                          <a href="{concat(substring-before($schemaHierarchy/@base, $intermediateXmlExtension), $extension, '#', $schemaHierarchy/@refId)}" 
                            ><xsl:value-of select="$schemaHierarchy/@schemaLocation"/></a></p>
                        <div id="{$uniqueId}" style="display:block">
                            <ul>
                                <xsl:for-each select="$schemaHierarchy">
                                    <xsl:apply-templates>
                                        <xsl:with-param name="parentSchema" select="$schemaHierarchy/@schemaLocation"/>
                                        <xsl:with-param name="uniqueId" select="$uniqueId"/>
                                        <xsl:with-param name="level">1</xsl:with-param>
                                    </xsl:apply-templates>
                                </xsl:for-each>
                            </ul>
                        </div>
                    </li>
                </ul>
            </xsl:if>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Process a directive and output a list item. Recursion is used so that a 
        tree like representation is build using lists.</xd:desc>
        <xd:param name="parentSchema">Parent schema for this directive.</xd:param>
    </xd:doc>
    <xsl:template match="directive">
        <xsl:param name="parentSchema"/>
        <xsl:param name="uniqueId"/>
        <xsl:param name="level" as="xs:integer"/>
        
        <xsl:variable name="directive" select="."/>
        <xsl:variable name="uniqueId">
            <xsl:choose>
                <xsl:when test="exists($directive/@refId)">
                    <xsl:value-of select="concat($uniqueId, $directive/@refId)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($uniqueId, $directive/@schemaLocation)"/>
                </xsl:otherwise>
            </xsl:choose>
            
        </xsl:variable>
        <xsl:variable name="image">
            <xsl:choose>
                <xsl:when test="not($directive/@cycle)">
                    <xsl:text>img/HierarchyArrow12.jpg</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>img/Cycle12.png</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="hasChildren" select="not(empty($directive/directive))"/>
        <li class="schemaHierarchy">
            <p>
                <xsl:variable name="btImage">
                    <xsl:choose>
                        <xsl:when test="$level = 1">
                            <xsl:text>img/btP.gif</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>img/btM.gif</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                
                <xsl:variable name="tooltip">
                    <!-- This is a tooltip-->
                    <xsl:value-of select="$scHierarchyTooltip/*[@key = $directive/@directiveType]/text()"/>
                    <xsl:text> '</xsl:text>
                    <xsl:value-of select="$parentSchema"/>
                    <xsl:text>'.</xsl:text>
                </xsl:variable>
                
                <xsl:if test="$hasChildren">
                    <input id="button_{$uniqueId}" type="image" value="-"
                        src="{$btImage}"
                        onclick="switchState('{$uniqueId}');" class="control"/>
                </xsl:if>
                
                <img src="{$image}">
                    <xsl:if test="$directive/@cycle">
                        <xsl:attribute name="title" select="concat($tooltip, ' Cycle detected.')"/>
                    </xsl:if>
                </img>
                <xsl:text> </xsl:text>
                <img src="{$scHierarchyIcons/*[@key = $directive/@directiveType]/text()}" title="{$tooltip}"/>
                <xsl:text> </xsl:text>
                                
                <xsl:choose>
                    <xsl:when test="exists($directive/@refId)">
                        <a  href="{concat(substring-before($directive/@base, $intermediateXmlExtension), $extension, '#', $directive/@refId)}"
                            >
                            <xsl:variable name="criteria" select="$splitInfo/@criteria"/>
                            <xsl:if test="compare($criteria, $chunkValueNone) != 0">
                                <xsl:attribute name="onclick" select="func:getTitle($directive, $criteria)"/>
                            </xsl:if>
                            <xsl:value-of select="$directive/@schemaLocation"/>
                        </a>        
                    </xsl:when>
                    <xsl:otherwise><xsl:value-of select="$directive/@schemaLocation"/></xsl:otherwise>
                </xsl:choose>
            </p>
            <xsl:if test="$hasChildren">
                <xsl:variable name="style">
                    <xsl:choose>
                        <xsl:when test="$level = 1">
                            <xsl:text>display:none</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>display:block</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    </xsl:variable>
                    <div id="{$uniqueId}" style="{$style}">
                    <ul>
                        <xsl:apply-templates>
                            <xsl:with-param name="parentSchema" select="$directive/@schemaLocation"/>
                            <xsl:with-param name="uniqueId" select="$uniqueId"/>
                            <xsl:with-param name="level" select="$level + 1"/>
                        </xsl:apply-templates>
                    </ul>
                </div>
            </xsl:if>
        </li>
    </xsl:template>
    
    <xsl:template match="text()"/>
</xsl:stylesheet>
