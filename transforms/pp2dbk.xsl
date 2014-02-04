<?xml version="1.0"?>
<!-- 
    PP-to-DocBook Stylesheet
	Author: Matt Benke (I4221)
    Version: 29 Jan 2014
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:exsl="http://exslt.org/common" xmlns:dyn="http://exslt.org/dynamic" xmlns:pp="http://www.commoncriteriaportal.org/ns/pp" xmlns:doc="http://docbook.org/ns/docbook" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://docbook.org/ns/docbook" exclude-result-prefixes="#default exsl dyn" emphasis.propagates.style="1">
	<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

	<!-- Extract Common Criteria XML from URL indicated by conformance claim. -->
	<!-- TO DO: Host CC XML unzipped so we don't have to use local copies.  You know, like actual web services. -->
	<xsl:variable name="ccXMLpath">
		<xsl:value-of select="//*[@role='APE_CCL.claim']/pp:CC_Conformance/@xlink:href" />
	</xsl:variable>
	<xsl:variable name="ccXML">
		<xsl:copy-of select="document(concat('../input/', $ccXMLpath))" />
	</xsl:variable>
	
	<!-- Render the PP as a <book>. -->
	<xsl:template match="pp:PP">
		<book xml:id="PP.doc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.docbook.org/xml/5.0/xsd/docbook.xsd" role="APE">
			<xsl:apply-templates select="@*|node()" />
		</book>
	</xsl:template>
	
	<!-- Derive PP Reference from metadata. -->
	<xsl:template match="pp:PP_Reference">
		<section role="APE_INT.reference">
			<info><title>PP Reference</title></info>
			<para>
				<xsl:value-of select="/pp:PP/doc:info/doc:title" />
				<xsl:text> </xsl:text>
				<xsl:value-of select="/pp:PP/doc:info/doc:edition" />
				,
				<xsl:value-of select="/pp:PP/doc:info/doc:author/doc:orgname" />
				,
				<xsl:value-of select="/pp:PP/doc:info/doc:date" />
			</para>
		</section>		
	</xsl:template>
	
	<!-- Derive CC conformance statement from CC to which @href refers and specified @part2 and @part3 "conformant"|"extended". -->
	<!-- 
		TO DO: 
		Change to absolute @href (and link to it) when unzipped CC XML gets hosted somewhere online. 
		Translate CC to DocBook <set> with proper <info> metadata including <title> and grab that for this reference.
	-->
	<xsl:template match="pp:CC_Conformance">
		<section role="APE_CCL.claim.CC">
			<info><title>Common Criteria</title></info>
			<para>
				This PP conforms to 
				Common Criteria Version <xsl:value-of select="exsl:node-set($ccXML)//cc/@version" /> Revision <xsl:value-of select="exsl:node-set($ccXML)//cc/@revision" />
				Part 2 (<xsl:value-of select="@part2" />) and Part 3 (<xsl:value-of select="@part3" />).
			</para>
		</section>
	</xsl:template>
	
	<!-- Generate statement about required conformance by STs and other PPs claiming to conform to this PP. -->
	<xsl:template match="pp:ConformanceRequired">
		<section role="APE_CCL.statement">
			<info><title>Statement</title></info>
			<para>Conformance to this PP by STs and other PPs must be <xsl:value-of select="@statement" />.</para>
		</section>
	</xsl:template>
	
	<!-- Render APE_SPD threats, OSPs, and assumptions as <simplesect>s -->
	<xsl:template match="pp:threat|pp:OSP|pp:assumption">
		<simplesect role="{concat('APE_SPD.', local-name())}">
			<xsl:apply-templates select="@*" />
			<info><title><xsl:value-of select="@xml:id" /></title></info>
			<xsl:apply-templates select="node()" />
		</simplesect>
	</xsl:template>

	<!-- Render APE_OBJ objectives for the OE and TOE as <simplesect>s -->
	<xsl:template match="pp:SO|pp:SOE">
		<simplesect role="{concat('APE_OBJ.', local-name())}">
			<xsl:apply-templates select="@*" />
			<info><title><xsl:value-of select="@xml:id" /></title></info>
			<xsl:apply-templates select="node()" />
		</simplesect>
	</xsl:template>
	
	<!-- Render APE_REQ/ECD functional and assurance requirements as <section>s -->
	<xsl:template match="pp:f-class|pp:f-family|pp:f-component|pp:f-element">
		<xsl:variable name="localName" select="local-name()" />
		<xsl:element name="section">
			<xsl:attribute name="label">
				<xsl:choose>
					<xsl:when test="@derives"><xsl:value-of select="translate(@derives, $lower, $upper)" /></xsl:when>
					<xsl:otherwise><xsl:value-of select="translate(@xml:id, $lower, $upper)" /></xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="role">
				<xsl:choose>
					<xsl:when test="local-name() = 'f-class'">APE_REQ.functional.class</xsl:when>
					<xsl:when test="local-name() = 'f-family'">APE_REQ.functional.family</xsl:when>
					<xsl:when test="local-name() = 'f-component'">APE_REQ.functional.component</xsl:when>
					<xsl:when test="local-name() = 'f-element'">APE_REQ.functional.element</xsl:when>
				</xsl:choose>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="@derives">
					<xsl:apply-templates select="@*[local-name() != 'derives']" />
					<info><title>
						<!-- This line is abominable, but what simpler way is there to extract the element matching a variable tag name and a variable @id? -->
						<!-- 
							TO DO: 
							Fix the CC XML so it doesn't use @id attributes except to identify the current element.
							Then the select statement here can be replaced with "exsl:node-set($ccXML)//*[@id=@derives]/@name" 
						-->
						<xsl:value-of select="dyn:evaluate(concat('exsl:node-set($ccXML)//', local-name(), '[@id=&quot;', @derives, '&quot;]/@name'))" />
					</title></info>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="@*[local-name() != 'name']" />
					<info><title><xsl:value-of select="@name" /></title></info>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="node()" />
		</xsl:element>
	</xsl:template>
	
	
	<!-- Render PP selectables and assignables (for which STs and other PPs can specify selections and assignments, respectively). -->
	
	<xsl:template match="pp:selectables">
		<phrase>
			<xsl:text>[selection</xsl:text>
			<xsl:if test="@exclusive = 'true'">
				<xsl:text>, choose one of</xsl:text>
			</xsl:if>
			<xsl:text>: </xsl:text>
			<simplelist type="inline" role="selectable">
				<xsl:apply-templates select="@*|node()" />
			</simplelist>
			<xsl:text>]</xsl:text>
		</phrase>
	</xsl:template>
	
	<xsl:template match="pp:selectable">
		<member><emphasis role="selectable"><xsl:apply-templates select="@*|node()" /></emphasis></member>
	</xsl:template>
	
	<xsl:template match="pp:assignable">
		<phrase>[assignment: <emphasis role="assignable"><xsl:apply-templates select="@*|node()" /></emphasis>]</phrase>
	</xsl:template>
	
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
