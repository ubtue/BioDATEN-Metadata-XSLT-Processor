<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0"
	encoding="UTF-8" indent="yes"/>

<xsl:template match="schemas/newSchema[@schema='datacite']/*[local-name()='resource']">
	<xsl:copy-of select="node()[local-name() !='rightsList']"></xsl:copy-of>
</xsl:template>	

<xsl:template match="schemas/newSchema[@schema='datacite']/*[local-name()='resource']/*[local-name()='rightsList']">
	<xsl:copy-of select="current()"></xsl:copy-of>
</xsl:template>	

<xsl:template match="schemas/newSchema[@schema='BiodatenMinimal']/*[local-name()='BiodatenMinimal']">
	<xsl:copy-of select="current()"></xsl:copy-of>
</xsl:template>	
	
	<xsl:template match='/'>
		<mets:mets 
		TYPE="dataset" 
		xmlns:mets="http://www.loc.gov/METS/"  
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
		xmlns:xlink="http://www.w3.org/1999/xlink"  
		xmlns:datacite="https://schema.datacite.org/meta/kernel-4.4/" 
		xmlns:premis="https://www.loc.gov/standards/premis/"
		xmlns:cmdp="http://www.clarin.eu/cmd/1/profiles/clarin.eu:cr1:p_1659015263825"
		ID="{generate-id(.)}">
		<xsl:attribute name="OBJID">[place_doi_here]</xsl:attribute>
		<xsl:attribute name="LABEL">
			<xsl:value-of select="schemas/newSchema[@schema='datacite']/*[local-name()='resource']/*[local-name()='titles']/*[local-name()='title']"/>
		</xsl:attribute>
		
			<mets:metsHdr>
				<xsl:attribute name="CREATEDATE"><xsl:value-of select="current-dateTime()"/></xsl:attribute>
				<mets:agent>
					<xsl:attribute name="ROLE">CREATOR</xsl:attribute>
					<xsl:attribute name="TYPE">ORGANIZATION</xsl:attribute>
					<mets:name>Bioinformatics DATa ENvironment</mets:name>
				</mets:agent>
			</mets:metsHdr>
		
			<mets:dmdSec>
				<xsl:attribute name="ID">dmdDatacite</xsl:attribute>
				<xsl:attribute name="CREATED"><xsl:value-of select="current-dateTime()"/></xsl:attribute>
				<mets:mdWrap>
					<xsl:attribute name="MDTYPE">OTHER</xsl:attribute>
					<xsl:attribute name="MDTYPEVERSION">4.4</xsl:attribute>
					<xsl:attribute name="OTHERMDTYPE"><xsl:value-of select="schemas/newSchema/@schema"/></xsl:attribute>
					<xsl:attribute name="CREATED"><xsl:value-of select="current-dateTime()"/></xsl:attribute>
					<mets:xmlData>
						<xsl:apply-templates select="schemas/newSchema[@schema='datacite']/*[local-name()='resource']"/>
					</mets:xmlData>
				</mets:mdWrap>
			</mets:dmdSec>
			
			<mets:dmdSec>
				<xsl:attribute name="ID">dmdBioDATEN</xsl:attribute>
				<xsl:attribute name="CREATED"><xsl:value-of select="current-dateTime()"/></xsl:attribute>
				<mets:mdWrap>
					<xsl:attribute name="MDTYPE">OTHER</xsl:attribute>
					<xsl:attribute name="MDTYPEVERSION">1.0</xsl:attribute>
					<xsl:attribute name="OTHERMDTYPE">BiodatenMinimal</xsl:attribute>
					<xsl:attribute name="CREATED"><xsl:value-of select="current-dateTime()"/></xsl:attribute>
					<mets:xmlData>
						<xsl:apply-templates select="schemas/newSchema[@schema='BiodatenMinimal']/*[local-name()='BiodatenMinimal']"/>
					</mets:xmlData>
				</mets:mdWrap>
			</mets:dmdSec>
		
			<mets:amdSec>
				<mets:rightsMD>
					<xsl:attribute name="ID">rightsmd</xsl:attribute>
					<xsl:attribute name="CREATED"><xsl:value-of select="current-dateTime()"/></xsl:attribute>
					<mets:mdWrap>
						<xsl:attribute name="MDTYPE">OTHER</xsl:attribute>
						<xsl:attribute name="MDTYPEVERSION">4.4</xsl:attribute>
						<xsl:attribute name="OTHERMDTYPE"><xsl:value-of select="schemas/newSchema/@schema"/></xsl:attribute>
						<xsl:attribute name="CREATED"><xsl:value-of select="current-dateTime()"/></xsl:attribute>
						<mets:xmlData>
							<xsl:apply-templates select="schemas/newSchema[@schema='datacite']/*[local-name()='resource']/*[local-name()='rightsList']"/>
						</mets:xmlData>
					</mets:mdWrap>
				</mets:rightsMD>
			</mets:amdSec>
			
			<mets:structMap>
				<xsl:attribute name="ID">structmap</xsl:attribute>
				<mets:div>
					<xsl:attribute name="ID">dataset123</xsl:attribute>
					<xsl:attribute name="ID">dataset</xsl:attribute>
					<xsl:attribute name="DMDID">dmdDatacite dmdBioDATEN</xsl:attribute>
					<xsl:attribute name="ADMID">rightsmd</xsl:attribute>
				</mets:div>
			</mets:structMap>
		</mets:mets>
	</xsl:template>
</xsl:stylesheet>