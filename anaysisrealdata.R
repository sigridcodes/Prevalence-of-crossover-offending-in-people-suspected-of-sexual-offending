# Define required packages for project and install missing packages
list.of.packages <- c("dplyr", "stringr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Create folders for data and outputs
dir.create('data', showWarnings = FALSE)
dir.create('data/raw_data', showWarnings = FALSE)
dir.create('data/processed_data', showWarnings = FALSE)
dir.create('data/metadata', showWarnings = FALSE)
dir.create('output', showWarnings = FALSE)
dir.create('R', showWarnings = FALSE)
dir.create('scripts', showWarnings = FALSE)
dir.create('Rmd', showWarnings = FALSE)

# load packages
library(dplyr)
library(stringr)

#set working directory
#put in the path where your datafile is stored on your pc
#you probably have to download the datasets (all .csv docs in the folder "mock data set") on your pc

#Julia's path
setwd("G:/FG3.2/Forschung/Projekte FGIII.2/2PS/Work Package/WP3/Daten Hessen/Daten_neu/Entpackte Orgialdaten/Kopierte Orginaldaten")

#Sigrid's path
#setwd("Users/sigridstolen/Documents/statistics/Mockdata") 

#Sara's path
#.libPaths("C:/Temp/R-Library") #this is something I (Sara) need to do to get R to work
#setwd("C:/Users/sja052/OneDrive - University of Bergen/Forschung/Daten_und_Projekte/2024 Collaboration DHPol/collab DHPol Sara MA students/Data log/mock data set")

#load file Sigrid
#CrimeAndVictimData <- read.csv2("./data/raw_data/mock_dataset_T.csv")
#OffenderData <- read.csv2("./data/raw_data/mock_dataset_P.csv")

#load file Julia
CrimeAndVictimData <- read.csv2("hashed_DHPOL_T-Gruppe_1 - identifizierte Täter.csv")
OffenderData <- read.csv2("hashed_DHPOL_P-Gruppe_1.csv")

# translate variable labels
OffenderData <- OffenderData %>%
  mutate(
    School_Education = Schulbildung,
    Gender = Geschlecht,
    Birth_Year = Geburtsjahr
  )

OffenderData$Gender <- recode(OffenderData$Gender,
                              "MAENNLICH" = "MALE",
                              "UNBEKANNT" = "UNKNOWN",
                              "WEIBLICH" = "FEMALE"
)                       

# View dataset
#View(OffenderData)
write.csv2(OffenderData, "./data/raw_data/mock_dataset_P.csv") # in case you want to look at it in Excel
names(CrimeAndVictimData)

names(CrimeAndVictimData)
CrimeAndVictimData$victim_gender <- CrimeAndVictimData$Opfergeschlecht
CrimeAndVictimData$victim_age <- CrimeAndVictimData$Opfer_Alter
CrimeAndVictimData$victim_relationship_spacial_social <- CrimeAndVictimData$Opfer_TV_Beziehung__raeumlich.sozial_
CrimeAndVictimData$victim_relationship_formal <- CrimeAndVictimData$Opfer_TV_Beziehung__formal_
CrimeAndVictimData$injury <- CrimeAndVictimData$Verletzung
CrimeAndVictimData$crime <- CrimeAndVictimData$Delikt
CrimeAndVictimData$victim_gender <- recode(CrimeAndVictimData$victim_gender,
                                           "DIVERS" = "DIVERSE",
                                           "MAENNLICH" = "MALE",
                                           "UNBEKANNT" = "UNKNOWN",
                                           "WEIBLICH" = "FEMALE")

OffenderData$School_Education <- recode(OffenderData$School_Education,
                                        "01 OHNE SCHULBILDUNG" = "NO SCHOOLING",
                                        "02 SONDERSCHULE" = "SPECIAL NEEDS SCHOOL",
                                        "03 GRUNDSCHULE / HAUPTSCHULE" = "PRIMARY SCHOOL / GENERAL SCHOOL (until 9th or 10th grade)",
                                        "04 MITTLERE REIFE / FACHOBERSCHULE" = "SCHOOL LEAVING CERTIFICATE (after 10 yrs of school) / VOCATIONAL SCHOOL (age 16 to 18)",
                                        "05 ABITUR / FACHHOCHSCHULE" = "SCHOOL LEAVING CERTIFICATE (certificate of general qualification for university entrance after 12 or 13 yrs of schooling) / UNIVERSITY OF APPLIED SCIENCES",
                                        "06 STUDIENABSCHLUSS" = "UNIVERSITY DEGREE",
                                        "07 LEHRABSCHLUSS" = "APPRENTICESHIP",
                                        "08 SCHULABSCHLUSS UNBEKANNT" = "SCHOOL COMPLETION UNKNOWN"
)

CrimeAndVictimData$victim_relationship_spacial_social <- recode(CrimeAndVictimData$victim_relationship_spacial_social,
                                                                "211 BETREUUNGSVERHAELTNIS IM KRANKENHAUS" = "Care Relationship in Hospital",
                                                                "212 BETREUUNGSVERHAELTNIS IM SENIOREN-/PFLEGEHEIM" = "Care Relationship in Nursing Home",
                                                                "219 BETREUUNGSVERHAELTNIS IM SONSTIGEN GESUNDHEITSWESEN" = "Care Relationship in Other Health Care",
                                                                "213 BETREUUNGSVERHAELTNIS IN DER HAEUSLICHEN PFLEGE" = "Care Relationship in Home Care",
                                                                "220 ERZIEHUNGS-/BETREUUNGSVERH. IM BILDUNGSWESEN" = "Educational Care Relationship in Education",
                                                                "290 ERZIEHUNGS-/BETREUUNGSVERH. IM SONSTIGEN BEREICH" = "Educational Care Relationship in Other Field",
                                                                "110 GEMEINSAMER HAUSHALT - ERZIEHUNGS-/BETREUUNGSVERH." = "Shared Household Educational Care Relationship",
                                                                "190 GEMEINSAMER HAUSHALT - SONSTIGES VERHAELTNIS" = "Shared Household Other Relationship",
                                                                "730 GESCHAEFTLICHE BEZIEHUNG" = "Business Relationship",
                                                                "800 KEINE BEZIEHUNG" = "No Relationship",
                                                                "710 NACHBARSCHAFT" = "Neighbourhood",
                                                                "799 SONSTIGE RAEUMLICHE UND/ODER SOZIALE NAEHE" = "Other Spatial Social Proximity",
                                                                "900 UNBEKANNT" = "UNKNOWN",
                                                                "720 ZUGEHOERIGKEIT ZUM GLEICHEN BETRIEB" = "Affiliation to Same Company"
)

CrimeAndVictimData$victim_relationship_formal <- recode(CrimeAndVictimData$victim_relationship_formal,
                                                        "200 BEKANNTSCHAFT" = "Acquaintance",
                                                        "620 BEKANNTSCHAFT/FREUNDSCHAFT" = "Acquaintance/Friendship",
                                                        "114 EHEMALIGER EHEPARTNER / LEBENSPARTNER" = "Former Spouse/Partner",
                                                        "111 EHEPARTNER" = "Spouse",
                                                        "125 ELTERN / PFLEGEELTERN" = "Parents/Foster Parents",
                                                        "610 ENGE FREUNDSCHAFT" = "Close Friendship",
                                                        "112 ENKEL" = "Grandchild",
                                                        "630 FLUECHTIGE BEKANNTSCHAFT" = "Casual Acquaintance",
                                                        "400 FLUECHTIGE VORBEZIEHUNG" = "Casual Past Relationship",
                                                        "700 FORMELLE SOZIALE BEZIEHUNGEN" = "Formal Social Relationships",
                                                        "127 GESCHWISTER" = "Siblings",
                                                        "126 GROSSELTERN" = "Grandparents",
                                                        "800 KEINE BEZIEHUNG" = "No Relationship",
                                                        "500 KEINE VORBEZIEHUNG" = "No Past Relationship",
                                                        "121 KINDER / PFLEGEKINDER" = "Children/Foster Children",
                                                        "300 LANDSMANN" = "Fellow Countryman",
                                                        "113 PARTNER NICHTEHELICHER LEBENSGEMEINSCHAFTEN" = "Partners in Cohabiting Relationships",
                                                        "128 SCHWIEGERELTERN / -SOHN / -TOCHTER" = "In-Laws",
                                                        "190 SONSTIGE ANGEHOERIGE" = "Other Relatives",
                                                        "900 UNGEKLAERT" = "Unresolved",
                                                        "100 VERWANDTSCHAFT/ANGEHOERIGER" = "Kinship/Relative"
)

CrimeAndVictimData$injury <- recode(CrimeAndVictimData$injury,
                                    "2 LEICHT VERLETZT" = "MINOR INJURY",
                                    "1 NICHT VERLETZT" = "NOT INJURED",
                                    "3 SCHWER VERLETZT" = "SERIOUS INJURY",
                                    "4 TOEDLICH VERLETZT" = "FATAL INJURY",
                                    "0 UNBEKANNT" = "UNKNOWN")

CrimeAndVictimData$crime <- recode(CrimeAndVictimData$crime,
                                   "11110000 VERGEWALTIGUNG (ALTBESTAND)" = "11110000 RAPE (OLD REGULATION)",
                                   "11110000 VERGEWALTIGUNG UEBERFALLARTIG (EINZELTAETER) GEMAESS par. 177 ABS. 6 NR. 1, ABS. 7 UND 8 STGB" = "11110000 ROBBERY RAPE (SINGLE PERPETRATOR) ACCORDING TO § 177 PARA. 6 NO. 1, ABS. 7 AND 8 PENAL CODE",
                                   "11120000 VERGEWALTIGUNG UEBERFALLARTIG (DURCH GRUPPEN) GEMAESS par. 177 ABS. 6 NR. 2, ABS. 7 UND 8 STGB" = "11120000 ROBBERY RAPE (BY GROUPS) ACCORDING TO § 177 PARA. 6 NO. 2, ABS. 7 AND 8 PENAL CODE",
                                   "11130000 VERGEWALTIGUNG DURCH GRUPPEN GEMAESS par. 177 ABS. 6 NR. 2, ABS. 7 UND 8 STGB" = "11130000 RAPE BY GROUPS ACCORDING TO § 177 PARA. 6 NO. 2, ABS. 7 AND 8 PENAL CODE",
                                   "11140000 SONSTIGE STRAFTATEN GEMAESS par. 177 ABS. 6 NR. 1, ABS. 7 UND 8 STGB" = "11140000 OTHER OFFENSES ACCORDING TO § 177 PARA. 6 NO. 1, ABS. 7 AND 8 PENAL CODE",
                                   "11150000 SEXUELLER UEBERGRIFF, SEXUELLE NOETIGUNG UND VERGEWALTIGUNG MIT TODESFOLGE GEMAESS par. 178 STGB" = "11150000 SEXUAL ASSAULT, SEXUAL COERCION AND RAPE RESULTING IN DEATH ACCORDING TO § 178 PENAL CODE",
                                   "11160000 SEXUELLER UEBERGRIFF GEMAESS par. 177 ABS. 1, 2, 3, 4, 7, 8 UND 9 STGB" = "11160000 SEXUAL ASSAULT ACCORDING TO § 177 PARA. 1, 2, 3, 4, 7, 8 AND 9 PENAL CODE",
                                   "11171000 VERGEWALTIGUNG par. 177 ABS. 6 NR. 1, 2 STGB (OHNE SCHL. 111730)" = "11171000 RAPE § 177 PARA. 6 NO. 1, 2 PENAL CODE (EXCLUDING 111730)",
                                   "11172000 VERGEWALTIGUNG IM BESONDERS SCHWEREN FALL par. 177 ABS. 6 NR. 1, 2 I. V. M. ABS. 7, 8 STGB" = "11172000 RAPE IN PARTICULARLY SERIOUS CASES § 177 PARA. 6 NO. 1, 2 IN CONJUNCTION WITH ABS. 7, 8 PENAL CODE",
                                   "11173000 VERGEWALTIGUNG VON WIDERSTANDSUNFAEHIGEN PERSONEN (par. 177 ABS. 2 NR. 1, ABS. 4) GEM. par. 177 ABS. 6 NR. 1, 2 STGB" = "11173000 RAPE OF PERSONS UNABLE TO RESIST (§ 177 PARA. 2 NO. 1, ABS. 4) ACC. § 177 ABS. 6 NO. 1, 2 PENAL CODE",
                                   "11181000 SEXUELLER UEBERGRIFF IM BESONDERS SCHWEREN FALL par. 177 ABS. 1, 2 (OHNE NR. 1) I. V. M. ABS. 6 NR. 2, ABS. 7, 8 STGB" = "11181000 SEXUAL ASSAULT IN PARTICULARLY SERIOUS CASES § 177 PARA. 1, 2 (EXCLUDING NO. 1) IN CONJUNCTION WITH ABS. 6 NO. 2, ABS. 7, 8 PENAL CODE",
                                   "11182000 SEXUELLE NOETIGUNG IM BESONDERS SCHWEREN FALL par. 177 ABS. 5 I. V. M. ABS. 6 NR. 2, ABS. 7, 8 STGB" = "11182000 SEXUAL COERCION IN PARTICULARLY SERIOUS CASES § 177 PARA. 5 IN CONJUNCTION WITH ABS. 6 NO. 2, ABS. 7, 8 PENAL CODE",
                                   "11183000 SEXUELLER UEBERGRIFF AN WIDERSTANDSUNFAEHIGEN PERSONEN IM BESONDERS SCHWEREN FALL par. 177 ABS 2 NR. 1, ABS. 4 I. V. M. ABS. 6 NR. 2, ABS. 7, 8 NR. 2 STGB" = "11183000 SEXUAL ASSAULT ON PERSONS UNABLE TO RESIST IN PARTICULARLY SERIOUS CASES § 177 ABS. 2 NO. 1, ABS. 4 IN CONJUNCTION WITH ABS. 6 NO. 2, ABS. 7, 8 NO. 2 PENAL CODE",
                                   "11301000 SEXUELLER MISSBRAUCH VON SCHUTZBEFOHLENEN" = "11301000 SEXUAL ABUSE OF DEPENDENT PERSONS",
                                   "11303000 SEXUELLER MISSBRAUCH - AUSNUTZUNG EINER AMTSSTELLUNG" = "11303000 SEXUAL ABUSE - MISUSE OF OFFICE",
                                   "11304000 SEXUELLER MISSBRAUCH - AUSNUTZUNG EINES BERATUNGS- / BEHANDLUNGS- / BETREUUNGSVERHAELTNISSES" = "11304000 SEXUAL ABUSE - MISUSE OF A COUNSELING/ TREATMENT/ SUPERVISION RELATIONSHIP",
                                   "11311000 SEXUELLER MISSBRAUCH VON SCHUTZBEFOHLENEN (KIND)" = "11311000 SEXUAL ABUSE OF DEPENDENT PERSONS (CHILD)",
                                   "11312000 SEXUELLER MISSBRAUCH VON GEFANGENEN / VERWAHRTEN (KIND)" = "11312000 SEXUAL ABUSE OF PRISONERS / DETAINED (CHILD)",
                                   "11312000 SEXUELLER MISSBRAUCH VON GEFANGNENEN / VERWAHRTEN UNTER AUSNUTZUNG DER STELLUNG Z. N. VON KINDERN" = "11312000 SEXUAL ABUSE OF PRISONERS / DETAINED BY EXPLOITING THEIR POSITION RELATING TO CHILDREN",
                                   "11313000 SEXUELLER MISSBRAUCH AUSNUTZUNG EINER AMTSSTELLUNG ZUM NACHTEIL VON KINDERN" = "11313000 SEXUAL ABUSE MISUSE OF OFFICE TO THE DETRIMENT OF CHILDREN",
                                   "11314000 SEXUELLER MISSBRAUCH UNTER AUSNUTZUNG EINES BERATUNGS- / BEHANDLUNG- / BETREUUNGSVERHAELTNISSES Z. N. VON KINDERN" = "11314000 SEXUAL ABUSE UNDER MISUSE OF A COUNSELING/ TREATMENT/ SUPERVISION RELATIONSHIP TO THE DETRIMENT OF CHILDREN",
                                   "13101000 HANDLUNGEN NACH par. 176 ABS. 5 STGB" = "13101000 ACTIONS UNDER § 176 ABS. 5 PENAL CODE",
                                   "13101100 SEXUELLER MISSBRAUCH VON KINDERN - KINDER FUER SEX. HANDLUNGEN ANBIETET, NACHWEIS VERSPRICHT par. 176 ABS. 1 NR. 3 STGB" = "13101100 SEXUAL ABUSE OF CHILDREN - OFFERING OR PROMISING CHILDREN FOR SEXUAL ACTS par. 176(1) No. 3 StGB",
                                   "13101200 SEXUELLER MISSBRAUCH VON KINDERN - KINDER FUER SEX. MISSBRAUCH OHNE KOERPERKONTAKT ANBIETET, NACHWEIS VERSPRICHT, ZUR TAT VERABREDET par. 176A ABS. 2 STGB" =  "13101200 SEXUAL ABUSE OF CHILDREN - OFFERING CHILDREN FOR SEXUAL ABUSE WITHOUT PHYSICAL CONTACT par. 176A(2) StGB",
                                   "13101300 SEXUELLER MISSBRAUCH VON KINDERN - KIND ZUM VORBEREITENDEN EINWIRKEN ANBIETET, NACHWEIS VERSPRICHT, ZUR TAT VERABREDET par. 176B ABS. 2 STGB" = "13101300 SEXUAL ABUSE OF CHILDREN - OFFERING CHILD FOR PREPARATORY ACTIONS par. 176B(2) StGB",
                                   "13110000 SEXUALDELIKTE Z. N. VON KINDERN - ALTBESTAND" = "13110000 SEXUAL OFFENSES AGAINST CHILDREN - LEGACY CASES",
                                   "13110000 SEXUELLE HANDLUNGEN NACH par. 176 (1) UND (2) STGB (KIND)" = "13110000 SEXUAL ACTS UNDER par. 176(1) AND (2) StGB (CHILD)",
                                   "13110000 SEXUELLER MISSBRAUCH VON KINDERN - SEXUELLE HANDLUNGEN AN KIND/DURCH KIND VORNEHMEN LAESST par. 176 ABS 1 NR. 1 UND 2 STGB" = "13110000 SEXUAL ABUSE OF CHILDREN - COMMITTING SEXUAL ACTS ON/WITH CHILD par. 176(1) No. 1 AND 2 StGB",
                                   "13120000 EXHIBITIONISTISCHE / SEXUELLE HANDLUNGEN VOR KINDERN par. 176 ABS. 4 NR. 1 STGB" = "13120000 EXHIBITIONISTIC/SEXUAL ACTS IN FRONT OF CHILDREN par. 176(4) No. 1 StGB",
                                   "13120000 EXHIBITIONISTISCHE/SEXUELLE HANDLUNGEN VOR KINDERN par. 176A ABS. 1 NR. 1 STGB" = "13120000 EXHIBITIONISTIC/SEXUAL ACTS IN FRONT OF CHILDREN par. 176A(1) No. 1 StGB",
                                   "13120000 EXHIBTION. / SEXUELLE HANDLUNGEN VOR KINDERN (ALTBESTAND)" = "13120000 EXHIBITIONISTIC/SEXUAL ACTS IN FRONT OF CHILDREN - LEGACY CASES",
                                   "13130000 SEXUELLE HANDLUNGEN NACH par. 176 ABS. 4 NR. 2 STGB" = "13130000 SEXUAL ACTS UNDER par. 176(4) No. 2 StGB",
                                   "13130000 SEXUELLER MISSBRAUCH VON KINDERN - TAETER BESTIMMT KIND, SEXUELLE HANDLUNGEN AN SICH SELBST VORZUNEHMEN par. 176A ABS 1 NR. 2 STGB" = "13130000 SEXUAL ABUSE OF CHILDREN - OFFENDER INSTRUCTS CHILD TO PERFORM SEXUAL ACTS ON THEMSELVES par. 176A(1) No. 2 StGB",
                                   "13140000 EINWIRKEN AUF KINDER NACH par. 176 ABS. 4 NR. 3 UND 4 STGB" = "13140000 ACTING ON CHILDREN UNDER par. 176(4) Nos. 3 AND 4 StGB",
                                   "13141100 SEXUELLER MISSBRAUCH VON KINDERN - EINWIRKEN AUF KIND DURCH PORNOGRAPHISCHEN INHALT ODER ENTSPRECHENDE REDEN par. 176A ABS. 1 NR. 3 STGB" = "13141100 SEXUAL ABUSE OF CHILDREN - ACTING ON CHILD THROUGH PORNOGRAPHIC CONTENT OR SPEECH par. 176A(1) No. 3 StGB",
                                   "13142100 SEXUELLER MISSBRAUCH VON KINDERN - EINWIRKEN AUF KIND ZUR VORBEREITUNG SEX. MISSBRAUCHS par. 176B ABS. 1 STGB" = "13142100 SEXUAL ABUSE OF CHILDREN - ACTING ON CHILD FOR PREPARATORY SEXUAL ABUSE par. 176B(1) StGB",
                                   "13150000 SCHWERER SEXUELLER MISSBRAUCH VON KINDERN - VOLLZUG DES BEISCHLAFS MIT EINEM KIND ODER VORNAHME EINER AEHNLICHEN SEXUELLEN HANDLUNG NACH par. 176C ABS. 1 NR. 2 STGB" = "13150000 SEVERE SEXUAL ABUSE OF CHILDREN - FULL SEXUAL INTERCOURSE OR SIMILAR ACTS WITH A CHILD par. 176C(1) No. 2 StGB",
                                   "13160000 SCHWERER SEXUELLER MISSBRAUCH VON KINDERN - HERSTELLUNG UND VERBREITUNG PORNOGRAPHISCHER SCHRIFTEN par. 176C ABS. 2 STGB" = "13160000 SEVERE SEXUAL ABUSE OF CHILDREN - PRODUCTION AND DISTRIBUTION OF PORNOGRAPHIC MATERIAL par. 176C(2) StGB",
                                   "13170000 SONSTIGER SCHWERER SEXUELLER MISSBRAUCH VON KINDERN NACH par. 176A STGB" = "13170000 OTHER SEVERE SEXUAL ABUSE OF CHILDREN par. 176A StGB",
                                   "13180000 SEXUELLER MISSBRAUCH VON KINDERN MIT TODESFOLGE par. 176B STGB" = "13180000 SEXUAL ABUSE OF CHILDREN RESULTING IN DEATH par. 176B StGB",
                                   "13300000 SEXUELLER MISSBRAUCH VON JUGENDLICHEN" = "13300000 SEXUAL ABUSE OF ADOLESCENTS",
                                   "13310000 SEXUELLER MISSBRAUCH VON JUGENDLICHEN GEGEN ENTGELT par. 182 ABS. 2 STGB" = "13310000 SEXUAL ABUSE OF ADOLESCENTS FOR PAYMENT par. 182(2) StGB",
                                   "13370000 SONSTIGER SEXUELLER MISSBRAUCH VON JUGENDLICHEN par. 182 STGB" = "13370000 OTHER SEXUAL ABUSE OF ADOLESCENTS par. 182 StGB",
                                   "14110000 FOERDERUNG SEXUELLER HANDLUNGEN MINDERJAEHRIGER" = "14110000 PROMOTING SEXUAL ACTS INVOLVING MINORS",
                                   "14111000 FOERDERUNG SEXUELLER HANDLUNGEN MINDERJAEHRIGER DURCH VERMITTLUNG ODER GEGEN ENTGELT par. 180 STGB, ABS. 1, NR. 1, ODER ABS. 2" = "14111000 PROMOTING SEXUAL ACTS INVOLVING MINORS THROUGH ARRANGEMENTS OR FOR PAYMENT par. 180(1) No. 1 OR 180(2) StGB",
                                   "14117900 SONSTIGE FOERDERUNG SEXUELLER HANDLUNGEN MINDERJAEHRIGER par. 180 STGB" = "14117900 OTHER PROMOTING SEXUAL ACTS INVOLVING MINORS par. 180 StGB",
                                   "14120000 AUSBEUTUNG VON PROSTITUIERTEN" = "14120000 EXPLOITATION OF PROSTITUTES"
)

#identify unique offender personal numbers
OffenderPersonalNumbers = unique(CrimeAndVictimData$P_Nummer_Personengrunddaten)
list(OffenderPersonalNumbers)
TotalOffendersIncludingOnlyOneOffence = length(OffenderPersonalNumbers)
print(TotalOffendersIncludingOnlyOneOffence)

# Define categories and function
RelationshipMapper <- function(Relationship){
  Stranger = list("No Past Relationship", "No Relationship", "Fellow Countryman")
  Acquaintance = list("Casual Past Relationship", "Acquaintance/Friendship", "Casual Acquaintance", "Formal Social Relationships", "Acquaintance","Former Spouse/Partner", "Close Friendship")
  Family = list("Parents/Foster Parents", "Kinship/Relative", "Grandchild", "Other Relatives", "Grandparents", "Children/Foster Children", "Siblings", "In-Laws", "Spouse", "Partners in Cohabiting Relationships")
  Undefined = list("NA", "Unresolved")
  if (Relationship %in% Stranger) {
    return ("Stranger")
  }
  else if (Relationship %in% Acquaintance){
    return ("Acquaintance")
  }
  else if (Relationship %in% Family) {
    return ("Family")
  }
  else {
    return ("Undefined")
  }
}

AgeMapper <- function(Age){
  if (is.na(Age)) {
    return ("Undefined")
  }
  if (Age <= 10) {
    return ("Pre-pubescent")
  }
  else if (Age >= 11 && Age <= 13){
    return ("Pubescent")
  }
  else if (Age >= 14 && Age <= 17) {
    return ("Post-pubescent")
  }
  else if (Age >=18) {
    return ("Adult")
  }
  else {
    return ("Undefined")
  }
}

DefineHasVictim <- function(HasVictimType, HasNa) {
  if (HasVictimType) {
    return(TRUE)
  }
  else if ( HasNa ){
    return("UNKNOWN")
  }
  else {
    return(FALSE)
  }
}

DefineHasCrossover <- function(VictimProfile) {
  NumberOfVictimTypes = 0
  ContainsNA = "UNKNOWN" %in% VictimProfile
  for (VictimType in VictimProfile) {
    if (VictimType == TRUE) {
      NumberOfVictimTypes = NumberOfVictimTypes + 1
    }
  }
  if (NumberOfVictimTypes > 1) {
    return(TRUE)
  }
  else if (ContainsNA) {
    return("UNKNOWN")
  }
  else{
    return(FALSE)
  }
}

DefineHasNonAdjacentCrossover <- function(HasPrePubescentVictim, HasPubescentVictim, HasPostPubescentVictim, HasAdultVictim, HasNaAgeVictim) {
  NonAdjacentCombination1 = HasPrePubescentVictim == TRUE && HasPostPubescentVictim == TRUE
  NonAdjacentCombination2 = HasPrePubescentVictim == TRUE && HasAdultVictim == TRUE
  NonAdjacentCombination3 = HasPubescentVictim == TRUE && HasAdultVictim == TRUE
  if (NonAdjacentCombination1 | NonAdjacentCombination2 | NonAdjacentCombination3){
    return(TRUE)
  }
  else if (HasNaAgeVictim) {
    return("UNKNOWN")
  }
  else {
    return(FALSE)
  }
}
# Generate offender profile
GenerateOffenderProfile <- function(OffenderPersonalNumber, CrimeAndVictimData) {
  OffenceHistory = CrimeAndVictimData[CrimeAndVictimData$P_Nummer_Personengrunddaten %in% OffenderPersonalNumber,]
  OffenderProfile = data.frame(OffenderPersonalNumber=OffenderPersonalNumber)
  OffenderProfile$NumberOfOffences = length(unique(OffenceHistory$T_Nummer_Fall))
  #OffenderProfile$NumberOfOffences = dim(OffenceHistory)[1]
  # Gender
  HasAtLeastOneFemaleVictim = "FEMALE" %in% OffenceHistory$victim_gender
  HasAtLeastOneMaleVictim = "MALE"   %in% OffenceHistory$victim_gender
  HasNaGenderVictim = sum(is.na(OffenceHistory$victim_gender)) > 0
  HasFemaleVictim = DefineHasVictim(HasAtLeastOneFemaleVictim, HasNaGenderVictim)
  HasMaleVictim = DefineHasVictim(HasAtLeastOneMaleVictim, HasNaGenderVictim)
  OffenderProfile$HasFemaleVictim = HasFemaleVictim
  OffenderProfile$HasMaleVictim = HasMaleVictim
  OffenderProfile$GenderCrossover = DefineHasCrossover(list(HasFemaleVictim, HasMaleVictim))
  
  #Violence
  HasInjuredAtLeastOneVictim = "FATAL INJURY" %in% OffenceHistory$injury | "SERIOUS INJURY" %in% OffenceHistory$injury
  OffenderProfile$HasInjuredVictim = HasInjuredAtLeastOneVictim
  
  # Age
  HasAtLeastOneChildUnderSixVictim = sum(OffenceHistory$victim_age <= 6, na.rm=TRUE) > 0
  HasAtLeastOnePrePubescentVictim = "Pre-pubescent" %in% OffenceHistory$MappedAge
  HasAtLeastOnePubescentVictim = "Pubescent" %in% OffenceHistory$MappedAge
  HasAtLeastOnePostPubescentVictim = "Post-pubescent" %in% OffenceHistory$MappedAge
  HasAtLeastOneAdultVictim = "Adult" %in% OffenceHistory$MappedAge
  HasNaAgeVictim = "Undefined" %in% OffenceHistory$MappedAge
  HasChildUnderSixVictim = DefineHasVictim(HasAtLeastOneChildUnderSixVictim, HasNaAgeVictim)
  HasPrePubescentVictim = DefineHasVictim(HasAtLeastOnePrePubescentVictim, HasNaAgeVictim)
  HasPubescentVictim = DefineHasVictim(HasAtLeastOnePubescentVictim, HasNaAgeVictim)
  HasPostPubescentVictim = DefineHasVictim(HasAtLeastOnePostPubescentVictim, HasNaAgeVictim)
  HasAdultVictim = DefineHasVictim(HasAtLeastOneAdultVictim, HasNaAgeVictim)
  OffenderProfile$HasChildUnderSixVictim = HasChildUnderSixVictim
  OffenderProfile$HasPrePubescentVictim = HasPrePubescentVictim
  OffenderProfile$HasPubescentVictim = HasPubescentVictim
  OffenderProfile$HasPostPubescentVictim = HasPostPubescentVictim
  OffenderProfile$HasAdultVictim = HasAdultVictim
  OffenderProfile$AgeCrossover = DefineHasCrossover(list(HasPrePubescentVictim, HasPubescentVictim, HasPostPubescentVictim, HasAdultVictim))
  OffenderProfile$NonAdjacentAgeCrossover = DefineHasNonAdjacentCrossover(HasPrePubescentVictim, HasPubescentVictim, HasPostPubescentVictim, HasAdultVictim, HasNaAgeVictim)
  
  # Relationship
  HasAtLeastOneFamilyVictim = "Family" %in% OffenceHistory$MappedRelationShip
  HasAtLeastOneAcquaintanceVictim = "Acquaintance" %in% OffenceHistory$MappedRelationShip
  HasAtLeastOneStrangerVictim = "Stranger" %in% OffenceHistory$MappedRelationShip
  HasNaRelationshipVictim = "Undefined" %in% OffenceHistory$MappedRelationShip
  HasFamilyVictim = DefineHasVictim(HasAtLeastOneFamilyVictim, HasNaRelationshipVictim)
  HasAcquaintanceVictim = DefineHasVictim(HasAtLeastOneAcquaintanceVictim, HasNaRelationshipVictim)
  HasStrangerVictim = DefineHasVictim(HasAtLeastOneStrangerVictim, HasNaRelationshipVictim)
  OffenderProfile$HasFamilyVictim = HasFamilyVictim
  OffenderProfile$HasAcquaintanceVictim = HasAcquaintanceVictim
  OffenderProfile$HasStrangerVictim = HasStrangerVictim
  OffenderProfile$RelationshipCrossover = DefineHasCrossover(list(HasFamilyVictim, HasAcquaintanceVictim, HasStrangerVictim))
  return (OffenderProfile)
  
}

GenerateOffenderStatistics <- function(OffenderPersonalNumbers, CrimeAndVictimData){
  OffenderStatistics = data.frame()
  for (OffenderPersonalNumber in OffenderPersonalNumbers) {
    OffenderProfile = GenerateOffenderProfile(OffenderPersonalNumber, CrimeAndVictimData)
    OffenderStatistics <- rbind(OffenderStatistics, OffenderProfile)
  }
  return(OffenderStatistics)
}

# Apply functions to data
CrimeAndVictimData$MappedRelationShip <- lapply(CrimeAndVictimData$victim_relationship_formal, RelationshipMapper)
CrimeAndVictimData$MappedAge <- lapply(CrimeAndVictimData$victim_age, AgeMapper)


# Generate offender statistics

OffenderStatistics = GenerateOffenderStatistics(OffenderPersonalNumbers, CrimeAndVictimData)


# -------------------------------------
# Compute statistical values 
# -------------------------------------

# Only consider serial offenders, as non-serial offenders cannot have gender crossover
SerialOffenderStatistics = OffenderStatistics[OffenderStatistics$NumberOfOffences > 1,]

SerialOffenderPersonalNumbers = SerialOffenderStatistics$OffenderPersonalNumber
SerialOffenderGender <- vector( length = length(SerialOffenderPersonalNumbers))

for (SerialOffenderIndex in 1:length(SerialOffenderPersonalNumbers)) {
  SerialOffenderInformation = OffenderData[OffenderData$P_Nummer_Personengrunddaten %in% SerialOffenderPersonalNumbers[SerialOffenderIndex],]
  SerialOffenderGender[SerialOffenderIndex] = SerialOffenderInformation$Gender[1]
}

# Compute probability that there are more offenders with gender crossover among offenders with child under six victims and write to file

TotalOffenders = dim(SerialOffenderStatistics)[1]
OverSixOffenders = sum(SerialOffenderStatistics$HasChildUnderSixVictim == FALSE, na.rm = TRUE )
OverSixOffendersWithGenderCrossover =  sum(SerialOffenderStatistics$GenderCrossover == TRUE & SerialOffenderStatistics$HasChildUnderSixVictim == FALSE, na.rm = TRUE)
UnderSixOffenders = sum(SerialOffenderStatistics$HasChildUnderSixVictim == TRUE, na.rm = TRUE)
UnderSixOffenderWithGenderCrossover = sum(SerialOffenderStatistics$HasChildUnderSixVictim == TRUE & SerialOffenderStatistics$GenderCrossover == TRUE, na.rm = TRUE)
UnknownAgeOffenders = sum(SerialOffenderStatistics$HasChildUnderSixVictim == "UNKNOWN", na.rm = TRUE)
print(OverSixOffenders)
names(OffenderData)

# Information about serial offenders
MaleSerialOffenders = sum(SerialOffenderGender == "MALE", na.rm = TRUE)
ProportionOfMaleSerialOffenders = MaleSerialOffenders/TotalOffenders
FemaleSerialOffenders = sum(SerialOffenderGender == "FEMALE", na.rm = TRUE)
ProportionOfFemaleSerialOffenders = FemaleSerialOffenders/TotalOffenders
UnknownGenderSerialOffenders = sum(SerialOffenderGender == "UNKNOWN", na.rm = TRUE)
ProportionOfUnknownGenderSerialOffenders = UnknownGenderSerialOffenders/TotalOffenders
print(ProportionOfFemaleSerialOffenders)

file.create("output/DataOnUnderSixOffenders.txt")
write(paste("Number of total (serial) offenders: ", toString(TotalOffenders)), "output/DataOnUnderSixOffenders.txt", append = TRUE)
write(paste("Number of over six offenders: ", toString(OverSixOffenders)), "output/DataOnUnderSixOffenders.txt", append = TRUE)
write(paste("Number of under six offenders: ", toString(UnderSixOffenders)), "output/DataOnUnderSixOffenders.txt", append = TRUE)
write(paste("Number of under six offenders with gender crossover: ", toString(UnderSixOffenderWithGenderCrossover)), "output/DataOnUnderSixOffenders.txt", append = TRUE)
write(paste("Number of unknown age offenders: ", toString(UnknownAgeOffenders)), "output/DataOnUnderSixOffenders.txt", append = TRUE)


# Compute proportion of gender crossover for offenders that only has victims above 6 years and write to file
ProportionGenderCrossoverOverSixOffenders = OverSixOffendersWithGenderCrossover / OverSixOffenders
print(ProportionGenderCrossoverOverSixOffenders)

file.create("output/DataOnCrossoverOffenders.txt")
write(paste("Proportion of gender crossover for over-six-offenders: ", toString(ProportionGenderCrossoverOverSixOffenders)), "output/DataOnCrossoverOffenders.txt", append = TRUE)

# Testing hypothesis1: "Among people who have committed repeated (at least two) sexual abuse, those who had any victim below age 6 are more likely to have victims of both sexes compared to those who only had victims above age 6"
# Get statistics for binom test https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/binom.test
# save to file
BinomtestUnder6vsOver6Differs = binom.test(x = UnderSixOffenderWithGenderCrossover, n = UnderSixOffenders, p = ProportionGenderCrossoverOverSixOffenders, alternative = c("two.sided"), conf.level = 0.95)

BinomtestUnder6vsOver6Greater = binom.test(x = UnderSixOffenderWithGenderCrossover, n = UnderSixOffenders, p = ProportionGenderCrossoverOverSixOffenders, alternative = c("greater"), conf.level = 0.95)


write(paste("BinomtestUnder6vsOver6Differs: ", toString(BinomtestUnder6vsOver6Differs)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("BinomtestUnder6vsOver6Greater: ", toString(BinomtestUnder6vsOver6Greater)), "output/DataOnCrossoverOffenders.txt", append = TRUE)

# Create diagram for overlap between age categories

groups <- c('HasPrePubescentVictim', 'HasPubescentVictim', 'HasPostPubescentVictim', 'HasAdultVictim')

overlapdata = matrix(c(1:16), ncol=4, byrow=TRUE)

for (colIndex in 1:length(groups)) {
  for (rowIndex in 1:length(groups)) {
    #overlapdata[colIndex, rowIndex] = sum(SerialOffenderStatistics[[groups[colIndex]]] == TRUE & SerialOffenderStatistics[[groups[rowIndex]]] == TRUE)
    if (colIndex <= rowIndex){
      overlapdata[colIndex, rowIndex] = sum(SerialOffenderStatistics[[groups[colIndex]]] == TRUE & SerialOffenderStatistics[[groups[rowIndex]]] == TRUE)
    }
    else {
      overlapdata[colIndex, rowIndex] = ''
    }
  }
}
colnames(overlapdata) = groups
rownames(overlapdata) = groups

overlapdatatable = as.table(overlapdata)

sum(SerialOffenderStatistics$HasPrePubescentVictim == TRUE & SerialOffenderStatistics$HasPubescentVictim == TRUE)

for (OffenderPersonalNumber in OffenderPersonalNumbers) {
  OffenderProfile = GenerateOffenderProfile(OffenderPersonalNumber, CrimeAndVictimData)
  OffenderStatistics <- rbind(OffenderStatistics, OffenderProfile)
}

# Create list for different types of crossover
NumberOfGenderCrossoverOffenders = sum(SerialOffenderStatistics$GenderCrossover == TRUE)
NumberOfNonGenderCrossoverOffenders = sum(SerialOffenderStatistics$GenderCrossover == FALSE)
NumberOfAgeCrossoverOffenders = sum(SerialOffenderStatistics$AgeCrossover == TRUE)
NumberOfNonAgeCrossoverOffenders = sum(SerialOffenderStatistics$AgeCrossover == FALSE)
NumberOfRelationshipCrossoverOffenders = sum(SerialOffenderStatistics$RelationshipCrossover == TRUE)
NumberOfNonRelationshipCrossoverOffenders = sum(SerialOffenderStatistics$RelationshipCrossover == FALSE)
NumberOfGenderAndAgeCrossoverOffenders = sum(SerialOffenderStatistics$GenderCrossover == TRUE & SerialOffenderStatistics$AgeCrossover == TRUE)
NumberOfGenderAndRelationshipCrossoverOffenders = sum(SerialOffenderStatistics$GenderCrossover == TRUE & SerialOffenderStatistics$RelationshipCrossover == TRUE)
NumberOfAgeAndRelationshipCrossoverOffenders = sum(SerialOffenderStatistics$AgeCrossover == TRUE & SerialOffenderStatistics$RelationshipCrossover == TRUE)
NumberOfGenderAgeAndRelationshipCrossoverOffenders = sum(SerialOffenderStatistics$GenderCrossover == TRUE & SerialOffenderStatistics$AgeCrossover == TRUE & SerialOffenderStatistics$RelationshipCrossover == TRUE)

OffenderStatisticsNoPersonalNumber = subset(OffenderStatistics, select = -c(OffenderPersonalNumber))
SerialOffenderStatisticsNoPersonalNumber = subset(SerialOffenderStatistics, select = -c(OffenderPersonalNumber))

# Find proportions for different types of crossover
ProportionOfGenderCrossoverOffenders = NumberOfGenderCrossoverOffenders/TotalOffenders
ProportionOfAgeCrossoverOffenders = NumberOfAgeCrossoverOffenders/TotalOffenders
ProportionOfRelationshipCrossoverOffenders = NumberOfRelationshipCrossoverOffenders/TotalOffenders
ProportionOfGenderAndAgeCrossoverOffenders = NumberOfGenderAndAgeCrossoverOffenders/TotalOffenders
ProportionOfGenderAndRelationshipCrossoverOffenders = NumberOfGenderAndRelationshipCrossoverOffenders/TotalOffenders
ProportionOfAgeAndRelationshipCrossoverOffenders = NumberOfAgeAndRelationshipCrossoverOffenders/TotalOffenders
ProportionOfGenderAgeAndRelationshipCrossoverOffenders = NumberOfGenderAgeAndRelationshipCrossoverOffenders/TotalOffenders

#Find average number of offences for non-crossover offenders and save to file
NonCrossoverOffenders = SerialOffenderStatistics[SerialOffenderStatistics$GenderCrossover == FALSE & SerialOffenderStatistics$AgeCrossover == FALSE & SerialOffenderStatistics$RelationshipCrossover == FALSE,]
NumberOfNonCrossoverOffenders = dim(NonCrossoverOffenders)[1]
NonCrossoverOffendersAverageNumberOfOffences = mean(NonCrossoverOffenders$NumberOfOffences)
NonGenderCrossoverOffenders = SerialOffenderStatistics[SerialOffenderStatistics$GenderCrossover == FALSE,]
NonRelationshipCrossoverOffenders = SerialOffenderStatistics[SerialOffenderStatistics$RelationshipCrossover == FALSE,]
NonAgeCrossoverOffenders = SerialOffenderStatistics[SerialOffenderStatistics$AgeCrossover == FALSE,]

file.create("output/DataOnNonCrossoverOffenders.txt")
write(paste("Average number of offences for non-crossover offenders: ", toString(NonCrossoverOffendersAverageNumberOfOffences)), "output/DataOnNonCrossoverOffenders.txt", append = TRUE)
write(paste("Number of non-crossover offenders: ", toString(NumberOfNonCrossoverOffenders)), "output/DataOnNonCrossoverOffenders.txt", append = TRUE)

#Find average number of offences for crossover offenders and save to file
AnyTypeCrossoverOffenders = SerialOffenderStatistics[SerialOffenderStatistics$GenderCrossover == TRUE | SerialOffenderStatistics$AgeCrossover == TRUE | SerialOffenderStatistics$RelationshipCrossover == TRUE,]
NumberOfAnyTypeCrossoverOffenders = dim(AnyTypeCrossoverOffenders)[1]
AnyTypeCrossoverOffendersAverageNumberOfOffences = mean(AnyTypeCrossoverOffenders$NumberOfOffences)
GenderCrossoverOffenders = SerialOffenderStatistics[SerialOffenderStatistics$GenderCrossover == TRUE,]
RelationshipCrossoverOffenders = SerialOffenderStatistics[SerialOffenderStatistics$RelationshipCrossover == TRUE,]
AgeCrossoverOffenders = SerialOffenderStatistics[SerialOffenderStatistics$AgeCrossover == TRUE,]

PValueGenderCrossoverForOffenderWithUnderSixVictim = UnderSixOffenderWithGenderCrossover / UnderSixOffenders
print(paste0("PValueGenderCrossoverForOffenderWithUnderSixVictim: ", PValueGenderCrossoverForOffenderWithUnderSixVictim))

# T-tests comparing number of offences differs for crossover offenders compared to specialized offenders
# T-test comparing number of offences differs for offenders with any type of crossover with any type of crossover vs those that do not have any crossover
TTestAnyTypeCrossoverOffendersDiffersNonCrossoverOffendersNumberOfOffences = t.test(x = AnyTypeCrossoverOffenders$NumberOfOffences, y = NonCrossoverOffenders$NumberOfOffences, alternative = c("two.sided"), paired = FALSE)

# T-test comparing number of offences differs for gender crossover offenders vs those that do not have gender crossover
TTestGenderCrossoverOffendersDiffersNonGenderCrossoverOffendersNumberOfOffences = t.test(x = GenderCrossoverOffenders$NumberOfOffences, y = NonGenderCrossoverOffenders$NumberOfOffences, alternative = c("two.sided"), paired = FALSE)

# T-test comparing number of offences differs for age crossover offenders vs those that do not have age crossover
TTestAgeCrossoverOffendersDiffersNonAgeCrossoverOffendersNumberOfOffences = t.test(x = AgeCrossoverOffenders$NumberOfOffences, y = NonAgeCrossoverOffenders$NumberOfOffences, alternative = c("two.sided"), paired = FALSE)

# T-test comparing number of offences differs for relationship crossover offenders vs those that do not have relationship crossover
TTestRelationshipCrossoverOffendersDiffersNonRelationshipCrossoverOffendersNumberOfOffences = t.test(x = RelationshipCrossoverOffenders$NumberOfOffences, y = NonRelationshipCrossoverOffenders$NumberOfOffences, alternative = c("two.sided"), paired = FALSE)

#P-values from the three tests
p_valNumberOfOffencesdiffersGENDER <- TTestGenderCrossoverOffendersDiffersNonGenderCrossoverOffendersNumberOfOffences$p.value
p_valNumberOfOffencesdiffersRELATIONSHIP <- TTestRelationshipCrossoverOffendersDiffersNonRelationshipCrossoverOffendersNumberOfOffences$p.value
p_valNumberOfOffencesdiffersAGE <- TTestAgeCrossoverOffendersDiffersNonAgeCrossoverOffendersNumberOfOffences$p.value
p_valuesNumberOfOffencesdiffers <- c(p_valNumberOfOffencesdiffersGENDER, p_valNumberOfOffencesdiffersRELATIONSHIP, p_valNumberOfOffencesdiffersAGE)
print(p_valuesNumberOfOffencesdiffers)

# Apply Holm-Bonferroni correction
NumberofOffencesdiffersAdjusted_p_values <- p.adjust(p_valuesNumberOfOffencesdiffers, method = "holm")

# Print adjusted p-values
print(NumberofOffencesdiffersAdjusted_p_values)

# Write to file
write(paste("Average number of offences for offenders with any type of crossover: ", toString(AnyTypeCrossoverOffendersAverageNumberOfOffences)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Number of offenders with any type of crossover: ", toString(NumberOfAnyTypeCrossoverOffenders)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("P-value for gender crossover for offenders with victim under six: ", toString(PValueGenderCrossoverForOffenderWithUnderSixVictim)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("T-test comparing number of offences differs for offenders with any type of crossover vs those that do not have any crossover:", toString(TTestAnyTypeCrossoverOffendersDiffersNonCrossoverOffendersNumberOfOffences)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("T-test comparing number of offences differs for gender crossover offenders vs those that do not have gender crossover:", toString(TTestGenderCrossoverOffendersDiffersNonGenderCrossoverOffendersNumberOfOffences)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("T-test comparing number of offences differs for age crossover offenders vs those that do not have age crossover:", toString(TTestAgeCrossoverOffendersDiffersNonAgeCrossoverOffendersNumberOfOffences)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("T-test comparing number of offences differs for relationship crossover offenders vs those that do not have relationship crossover:", toString(TTestRelationshipCrossoverOffendersDiffersNonRelationshipCrossoverOffendersNumberOfOffences)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Number of offences differs: Holm-Bonferroni adjusted p-values for gender, relationship and age crossover: ", toString(NumberofOffencesdiffersAdjusted_p_values)), "output/DataOnCrossoverOffenders.txt", append = TRUE)

# T-tests comparing number of offences is greater for crossover offenders compared to specialized offenders
# T-test testing if number of offences is greater for offenders with any type of crossover vs those that do not have any crossover
TTestAnyTypeCrossoverOffendersGreaterNonCrossoverOffendersNumberOfOffences = t.test(x = AnyTypeCrossoverOffenders$NumberOfOffences, y = NonCrossoverOffenders$NumberOfOffences, alternative = c("greater"), paired = FALSE)

# T-test testing if number of offences is greater for gender crossover offenders vs those that do not have gender crossover
TTestGenderCrossoverOffendersGreaterNonGenderCrossoverOffendersNumberOfOffences = t.test(x = GenderCrossoverOffenders$NumberOfOffences, y = NonGenderCrossoverOffenders$NumberOfOffences, alternative = c("greater"), paired = FALSE)

# T-test testing if number of offences is greater for age crossover offenders vs those that do not have age crossover
TTestAgeCrossoverOffendersGreaterNonAgeCrossoverOffendersNumberOfOffences = t.test(x = AgeCrossoverOffenders$NumberOfOffences, y = NonAgeCrossoverOffenders$NumberOfOffences, alternative = c("greater"), paired = FALSE)

# T-test testing if number of offences is greater for relationship crossover offenders vs those that do not have relationship crossover
TTestRelationshipCrossoverOffendersGreaterNonRelationshipCrossoverOffendersNumberOfOffences = t.test(x = RelationshipCrossoverOffenders$NumberOfOffences, y = NonRelationshipCrossoverOffenders$NumberOfOffences, alternative = c("greater"), paired = FALSE)

#P-values from the three tests
p_valNumberOfOffencesgreaterGENDER <- TTestGenderCrossoverOffendersGreaterNonGenderCrossoverOffendersNumberOfOffences$p.value
p_valNumberOfOffencesgreaterRELATIONSHIP <- TTestRelationshipCrossoverOffendersGreaterNonRelationshipCrossoverOffendersNumberOfOffences$p.value
p_valNumberOfOffencesgreaterAGE <- TTestAgeCrossoverOffendersGreaterNonAgeCrossoverOffendersNumberOfOffences$p.value
p_valuesNumberOfOffencesgreater <- c(p_valNumberOfOffencesgreaterGENDER, p_valNumberOfOffencesgreaterRELATIONSHIP, p_valNumberOfOffencesgreaterAGE)
print(p_valuesNumberOfOffencesgreater)

# Apply Holm-Bonferroni correction
NumberofOffencesgreaterAdjusted_p_values <- p.adjust(p_valuesNumberOfOffencesgreater, method = "holm")

# Print adjusted p-values
print(NumberofOffencesgreaterAdjusted_p_values)

# Write to file
write(paste("T-test testing if number of offences is greater for offenders with any type of crossover vs those that do not have any crossover:", toString(TTestAnyTypeCrossoverOffendersGreaterNonCrossoverOffendersNumberOfOffences)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("T-test testing if number of offences is greater for gender crossover offenders vs those that do not have gender crossover:", toString(TTestGenderCrossoverOffendersGreaterNonGenderCrossoverOffendersNumberOfOffences)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("T-test testing if number of offences is greater for age crossover offenders vs those that do not have age crossover:", toString(TTestAgeCrossoverOffendersGreaterNonAgeCrossoverOffendersNumberOfOffences)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("T-test testing if number of offences is greater for relationship crossover offenders vs those that do not have relationship crossover:", toString(TTestRelationshipCrossoverOffendersGreaterNonRelationshipCrossoverOffendersNumberOfOffences)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Number of offences is greater: Holm-Bonferroni adjusted p-values for gender, relationship and age crossover: ", toString(NumberofOffencesgreaterAdjusted_p_values)), "output/DataOnCrossoverOffenders.txt", append = TRUE)

#Gender crossover for different victim age groups 
HasChildUnderSixVictimAndGenderCrossover = sum(SerialOffenderStatistics$GenderCrossover == TRUE & SerialOffenderStatistics$HasChildUnderSixVictim == TRUE)
HasPrepubecentVictimAndGenderCrossover = sum(SerialOffenderStatistics$GenderCrossover == TRUE & SerialOffenderStatistics$HasPrePubescentVictim == TRUE)
HasPubecentVictimAndGenderCrossover = sum(SerialOffenderStatistics$GenderCrossover == TRUE & SerialOffenderStatistics$HasPubescentVictim == TRUE)
HasPostpubecentVictimAndGenderCrossover = sum(SerialOffenderStatistics$GenderCrossover == TRUE & SerialOffenderStatistics$HasPostPubescentVictim == TRUE)
HasAdultVictimAndGenderCrossover = sum(SerialOffenderStatistics$GenderCrossover == TRUE & SerialOffenderStatistics$HasAdultVictim == TRUE)
HasChildUnderSixVictimAndNoGenderCrossover = sum(SerialOffenderStatistics$GenderCrossover == FALSE & SerialOffenderStatistics$HasChildUnderSixVictim == TRUE)
HasPrepubecentVictimAndNoGenderCrossover = sum(SerialOffenderStatistics$GenderCrossover == FALSE & SerialOffenderStatistics$HasPrePubescentVictim == TRUE)
HasPubecentVictimAndNoGenderCrossover = sum(SerialOffenderStatistics$GenderCrossover == FALSE & SerialOffenderStatistics$HasPubescentVictim == TRUE)
HasPostpubecentVictimAndNoGenderCrossover = sum(SerialOffenderStatistics$GenderCrossover == FALSE & SerialOffenderStatistics$HasPostPubescentVictim == TRUE)
HasAdultVictimAndNoGenderCrossover = sum(SerialOffenderStatistics$GenderCrossover == FALSE & SerialOffenderStatistics$HasAdultVictim == TRUE)

TotalOffendersWithPrepubescentVictim = sum(SerialOffenderStatistics$HasPrePubescentVictim == TRUE)
TotalOffendersWithPubescentVictim = sum(SerialOffenderStatistics$HasPubescentVictim == TRUE)
TotalOffendersWithPostpubescentVictim = sum(SerialOffenderStatistics$HasPostPubescentVictim == TRUE)
TotalOffendersWithAdultVictim = sum(SerialOffenderStatistics$HasAdultVictim == TRUE)
print(TotalOffendersWithAdultVictim)


Rownamesgendercrossovertable <- c('Prepubescent victim', 'Pubescent victim', 'Postpubescent victim', 'Adult victim')
Colnamesgendercrossovertable <- c('One Gender', 'Both Gender', 'Total')

Gendercrossovertable = matrix(c(1:12), ncol=3, byrow=TRUE)
Gendercrossovertable[1, 1] = HasPrepubecentVictimAndNoGenderCrossover
Gendercrossovertable[2, 1] = HasPubecentVictimAndNoGenderCrossover
Gendercrossovertable[3, 1] = HasPostpubecentVictimAndNoGenderCrossover
Gendercrossovertable[4, 1] = HasAdultVictimAndNoGenderCrossover
Gendercrossovertable[1, 2] = HasPrepubecentVictimAndGenderCrossover
Gendercrossovertable[2, 2] = HasPubecentVictimAndGenderCrossover
Gendercrossovertable[3, 2] = HasPostpubecentVictimAndGenderCrossover
Gendercrossovertable[4, 2] = HasAdultVictimAndGenderCrossover
Gendercrossovertable[1, 3] = HasPrepubecentVictimAndGenderCrossover + HasPrepubecentVictimAndNoGenderCrossover
Gendercrossovertable[2, 3] = HasPubecentVictimAndGenderCrossover + HasPubecentVictimAndNoGenderCrossover
Gendercrossovertable[3, 3] = HasPostpubecentVictimAndGenderCrossover + HasPostpubecentVictimAndNoGenderCrossover
Gendercrossovertable[4, 3] = HasAdultVictimAndGenderCrossover + HasAdultVictimAndNoGenderCrossover

colnames(Gendercrossovertable) = Colnamesgendercrossovertable
rownames(Gendercrossovertable) = Rownamesgendercrossovertable

file.create("output/gendercrossovertable.csv")
write.table(Gendercrossovertable, "output/gendercrossovertable.csv", append = FALSE, sep = ",", dec = ".", row.names = TRUE, col.names = TRUE)

file.create("output/gendercrossovertable.txt")
write.table(overlapdatatable, "output/gendercrossovertable.txt", append = FALSE, sep = ",", dec = ".", row.names = TRUE, col.names = TRUE)

GendercrossovertableWithoutTotal = Gendercrossovertable[1:3,1:2]
resultschitest = chisq.test(GendercrossovertableWithoutTotal)
print(resultschitest)

file.create("output/ResultChiTestGenderCrossover.txt")
write(paste("Result chi test for gender crossover with different age groups: ", toString(resultschitest)), "output/ResultChiTestGenderCrossover.txt", append = TRUE)

#Gender crossover for different age groups in proportions and save to file
OffendersWithUnknownGenderCrossover = TotalOffenders - sum(SerialOffenderStatistics$GenderCrossover == FALSE | SerialOffenderStatistics$GenderCrossover == TRUE)
ProportionHasChildUnderSixVictimAndGenderCrossover = HasChildUnderSixVictimAndGenderCrossover / (HasChildUnderSixVictimAndGenderCrossover + HasChildUnderSixVictimAndNoGenderCrossover)
ProportionHasPrepubecentVictimAndGenderCrossover =  HasPrepubecentVictimAndGenderCrossover / (HasPrepubecentVictimAndGenderCrossover + HasPrepubecentVictimAndNoGenderCrossover)
ProportionHasPubecentVictimAndGenderCrossover =  HasPubecentVictimAndGenderCrossover / (HasPubecentVictimAndGenderCrossover + HasPubecentVictimAndNoGenderCrossover)
ProportionHasPostpubecentVictimAndGenderCrossover =  HasPostpubecentVictimAndGenderCrossover / (HasPostpubecentVictimAndGenderCrossover + HasPostpubecentVictimAndNoGenderCrossover)
ProportionHasAdultVictimAndGenderCrossover = HasAdultVictimAndGenderCrossover / (HasAdultVictimAndGenderCrossover + HasAdultVictimAndNoGenderCrossover)
ProportionHasChildUnderSixVictimAndNoGenderCrossover = HasChildUnderSixVictimAndNoGenderCrossover / (HasChildUnderSixVictimAndGenderCrossover + HasChildUnderSixVictimAndNoGenderCrossover)
ProportionHasPrepubecentVictimAndNoGenderCrossover =  HasPrepubecentVictimAndNoGenderCrossover / (HasPrepubecentVictimAndGenderCrossover + HasPrepubecentVictimAndNoGenderCrossover)
ProportionHasPubecentVictimAndNoGenderCrossover =  HasPubecentVictimAndNoGenderCrossover / (HasPubecentVictimAndGenderCrossover + HasPubecentVictimAndNoGenderCrossover)
ProportionHasPostpubecentVictimAndNoGenderCrossover =  HasPostpubecentVictimAndNoGenderCrossover / (HasPostpubecentVictimAndGenderCrossover + HasPostpubecentVictimAndNoGenderCrossover)
ProportionHasAdultVictimAndNoGenderCrossover = HasAdultVictimAndNoGenderCrossover / (HasAdultVictimAndGenderCrossover + HasAdultVictimAndNoGenderCrossover)
ProportionOffendersWithUnknownGenderCrossover = OffendersWithUnknownGenderCrossover / TotalOffenders

file.create("output/GenderCrossoverForDifferentVictimAgeGroups.txt")
write(paste("Has child under six victim and gender crossover: ", toString(HasChildUnderSixVictimAndGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Proportion has child under six victim and gender crossover: ", toString(ProportionHasChildUnderSixVictimAndGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Has prepubescent victim and gender crossover: ", toString(HasPrepubecentVictimAndGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Proportion has prepubescent victim and gender crossover: ", toString(ProportionHasPrepubecentVictimAndGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Has pubescent victim and gender crossover: ", toString(HasPubecentVictimAndGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Proportion has pubescent victim and gender crossover: ", toString(ProportionHasPubecentVictimAndGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)      
write(paste("Has postpubescent victim and gender crossover: ", toString(HasPostpubecentVictimAndGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Proportion has postpubescent victim and gender crossover: ", toString(ProportionHasPostpubecentVictimAndGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Has adult victim and gender crossover: ", toString(HasAdultVictimAndGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Proportion has adult victim and gender crossover: ", toString(ProportionHasAdultVictimAndGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Has child under six victim and no gender crossover: ", toString(HasChildUnderSixVictimAndNoGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Proportion has child under six victim and no gender crossover: ", toString(ProportionHasChildUnderSixVictimAndNoGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Has prepubescent victim and no gender crossover: ", toString(HasPrepubecentVictimAndNoGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Proportion has prepubescent victim and no gender crossover: ", toString(ProportionHasPrepubecentVictimAndNoGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Has pubescent victim and no gender crossover: ", toString(HasPubecentVictimAndNoGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Proportion has pubescent victim and no gender crossover: ", toString(ProportionHasPubecentVictimAndNoGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)      
write(paste("Has postpubescent victim and no gender crossover: ", toString(HasPostpubecentVictimAndNoGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Proportion has postpubescent victim and no gender crossover: ", toString(ProportionHasPostpubecentVictimAndNoGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Has adult victim and no gender crossover: ", toString(HasAdultVictimAndNoGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Proportion has adult victim and no gender crossover: ", toString(ProportionHasAdultVictimAndNoGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Offenders with unknown gender crossover: ", toString(OffendersWithUnknownGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)
write(paste("Proportion of offenders with unknown gender crossover: ", toString(ProportionOffendersWithUnknownGenderCrossover)), "output/GenderCrossoverForDifferentVictimAgeGroups.txt", append = TRUE)

#Violence for different victim age groups 
HasChildUnderSixVictimAndHasInjuredVictim = sum(SerialOffenderStatistics$HasInjuredVictim == TRUE & SerialOffenderStatistics$HasChildUnderSixVictim == TRUE)
HasPrepubecentVictimAndHasInjuredVictim = sum(SerialOffenderStatistics$HasInjuredVictim == TRUE & SerialOffenderStatistics$HasPrePubescentVictim == TRUE)
HasPubecentVictimAndHasInjuredVictim = sum(SerialOffenderStatistics$HasInjuredVictim == TRUE & SerialOffenderStatistics$HasPubescentVictim == TRUE)
HasPostpubecentVictimAndHasInjuredVictim = sum(SerialOffenderStatistics$HasInjuredVictim == TRUE & SerialOffenderStatistics$HasPostPubescentVictim == TRUE)
HasAdultVictimAndHasInjuredVictim = sum(SerialOffenderStatistics$HasInjuredVictim == TRUE & SerialOffenderStatistics$HasAdultVictim == TRUE)
HasChildUnderSixVictimAndNoHasInjuredVictim = sum(SerialOffenderStatistics$HasInjuredVictim == FALSE & SerialOffenderStatistics$HasChildUnderSixVictim == TRUE)
HasPrepubecentVictimAndNoHasInjuredVictim = sum(SerialOffenderStatistics$HasInjuredVictim == FALSE & SerialOffenderStatistics$HasPrePubescentVictim == TRUE)
HasPubecentVictimAndNoHasInjuredVictim = sum(SerialOffenderStatistics$HasInjuredVictim == FALSE & SerialOffenderStatistics$HasPubescentVictim == TRUE)
HasPostpubecentVictimAndNoHasInjuredVictim = sum(SerialOffenderStatistics$HasInjuredVictim == FALSE & SerialOffenderStatistics$HasPostPubescentVictim == TRUE)
HasAdultVictimAndNoHasInjuredVictim = sum(SerialOffenderStatistics$HasInjuredVictim == FALSE & SerialOffenderStatistics$HasAdultVictim == TRUE)
OffendersWithUnknownViolence = TotalOffenders - sum(SerialOffenderStatistics$HasInjuredVictim == FALSE | SerialOffenderStatistics$HasInjuredVictim == TRUE)

RownamesHasInjuredVictimtable <- c('Prepubescent victim', 'Pubescent victim', 'Postpubescent victim', 'Adult victim')
ColnamesHasInjuredVictimtable <- c('No violence', 'Violence', 'Total')

HasInjuredVictimtable = matrix(c(1:12), ncol=3, byrow=TRUE)
HasInjuredVictimtable[1, 1] = HasPrepubecentVictimAndNoHasInjuredVictim
HasInjuredVictimtable[2, 1] = HasPubecentVictimAndNoHasInjuredVictim
HasInjuredVictimtable[3, 1] = HasPostpubecentVictimAndNoHasInjuredVictim
HasInjuredVictimtable[4, 1] = HasAdultVictimAndNoHasInjuredVictim
HasInjuredVictimtable[1, 2] = HasPrepubecentVictimAndHasInjuredVictim
HasInjuredVictimtable[2, 2] = HasPubecentVictimAndHasInjuredVictim
HasInjuredVictimtable[3, 2] = HasPostpubecentVictimAndHasInjuredVictim
HasInjuredVictimtable[4, 2] = HasAdultVictimAndHasInjuredVictim
HasInjuredVictimtable[1, 3] = HasPrepubecentVictimAndHasInjuredVictim + HasPrepubecentVictimAndNoHasInjuredVictim
HasInjuredVictimtable[2, 3] = HasPubecentVictimAndHasInjuredVictim + HasPubecentVictimAndNoHasInjuredVictim
HasInjuredVictimtable[3, 3] = HasPostpubecentVictimAndHasInjuredVictim + HasPostpubecentVictimAndNoHasInjuredVictim
HasInjuredVictimtable[4, 3] = HasAdultVictimAndHasInjuredVictim + HasAdultVictimAndNoHasInjuredVictim

colnames(HasInjuredVictimtable) = ColnamesHasInjuredVictimtable
rownames(HasInjuredVictimtable) = RownamesHasInjuredVictimtable

file.create("output/HasInjuredVictimtable.csv")
write.table(HasInjuredVictimtable, "output/HasInjuredVictimtable.csv", append = FALSE, sep = ",", dec = ".", row.names = TRUE, col.names = TRUE)

file.create("output/HasInjuredVictimtable.txt")
write.table(HasInjuredVictimtable, "output/HasInjuredVictimtable.txt", append = FALSE, sep = ",", dec = ".", row.names = TRUE, col.names = TRUE)

HasInjuredVictimtableWithoutTotal = HasInjuredVictimtable[1:4,1:2]
resultschitest = chisq.test(HasInjuredVictimtableWithoutTotal)
print(resultschitest)

file.create("output/ResultChiTestHasInjuredVictim.txt")
write(paste("Result chi test for gender crossover with different age groups: ", toString(resultschitest)), "output/ResultChiTestHasInjuredVictim.txt", append = TRUE)

#Testing violence hypothesis
OffendersWithViolenceAndGenderCrossover = sum(SerialOffenderStatistics$HasInjuredVictim == TRUE & SerialOffenderStatistics$GenderCrossover == TRUE)
OffendersWithViolenceAndRelationshipCrossover = sum(SerialOffenderStatistics$HasInjuredVictim == TRUE & SerialOffenderStatistics$RelationshipCrossover == TRUE)
OffendersWithViolenceAndAgeCrossover = sum(SerialOffenderStatistics$HasInjuredVictim == TRUE & SerialOffenderStatistics$AgeCrossover == TRUE)
OffendersWithViolenceAndNoGenderCrossover = sum(SerialOffenderStatistics$HasInjuredVictim == TRUE & SerialOffenderStatistics$GenderCrossover == FALSE)
OffendersWithViolenceAndNoRelationshipCrossover = sum(SerialOffenderStatistics$HasInjuredVictim == TRUE & SerialOffenderStatistics$RelationshipCrossover == FALSE)
OffendersWithViolenceAndNoAgeCrossover = sum(SerialOffenderStatistics$HasInjuredVictim == TRUE & SerialOffenderStatistics$AgeCrossover == FALSE)
OffendersWithViolence = sum(SerialOffenderStatistics$HasInjuredVictim == TRUE)
OffendersWithNoGenderCrossover = sum(SerialOffenderStatistics$GenderCrossover == FALSE)
OffendersWithNoAgeCrossover = sum(SerialOffenderStatistics$AgeCrossover == FALSE)
OffendersWithNoRelationshipCrossover = sum(SerialOffenderStatistics$RelationshipCrossover == FALSE)
ProportionOffendersWithViolenceAndNoGenderCrossover = OffendersWithViolenceAndNoGenderCrossover / OffendersWithNoGenderCrossover
ProportionOffendersWithViolenceAndNoRelationshipCrossover = OffendersWithViolenceAndNoRelationshipCrossover / OffendersWithNoRelationshipCrossover
ProportionOffendersWithViolenceAndNoAgeCrossover = OffendersWithViolenceAndNoAgeCrossover / OffendersWithNoAgeCrossover
OffendersWithUnknownAgeCrossover = TotalOffenders - sum(SerialOffenderStatistics$AgeCrossover == FALSE | SerialOffenderStatistics$AgeCrossover == TRUE)
OffendersWithUnknownRelationshipCrossover = TotalOffenders - sum(SerialOffenderStatistics$RelationshipCrossover == FALSE | SerialOffenderStatistics$RelationshipCrossover == TRUE)

write(paste("Offenders with violence and gender crossover: ", toString(OffendersWithViolenceAndGenderCrossover)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Offenders with violence and relationship crossover: ", toString(OffendersWithViolenceAndRelationshipCrossover)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Offenders with violence and age crossover: ", toString(OffendersWithViolenceAndAgeCrossover)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Offenders with violence and no gender crossover: ", toString(OffendersWithViolenceAndNoGenderCrossover)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Offenders with violence and no relationship crossover: ", toString(OffendersWithViolenceAndNoRelationshipCrossover)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Offenders with violence and no age crossover: ", toString(OffendersWithViolenceAndNoAgeCrossover)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Offenders with violence: ", toString(OffendersWithViolence)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Proportion of offenders with violence and no gender crossover: ", toString(ProportionOffendersWithViolenceAndNoGenderCrossover)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Proportion of offenders with violence and no relationship crossover: ", toString(ProportionOffendersWithViolenceAndNoRelationshipCrossover)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Proportion of offenders with violence and no age crossover: ", toString(ProportionOffendersWithViolenceAndNoAgeCrossover)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Offenders with unknown gender crossover: ", toString(OffendersWithUnknownGenderCrossover)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Offenders with unknown age crossover: ", toString(OffendersWithUnknownAgeCrossover)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Offenders with unknown relationship crossover: ", toString(OffendersWithUnknownRelationshipCrossover)), "output/DataOnCrossoverOffenders.txt", append = TRUE)

# Testing if number of offenders who have injured at least one victim differs between crossover and specialized offenders
BinomtestviolencediffersGENDER = binom.test(x = OffendersWithViolenceAndGenderCrossover, n = NumberOfGenderCrossoverOffenders, p = ProportionOffendersWithViolenceAndNoGenderCrossover, alternative = c("two.sided"), conf.level = 0.95)
BinomtestviolencediffersRELATIONSHIP = binom.test(x = OffendersWithViolenceAndRelationshipCrossover, n = NumberOfRelationshipCrossoverOffenders, p = ProportionOffendersWithViolenceAndNoRelationshipCrossover, alternative = c("two.sided"), conf.level = 0.95)
BinomtestviolencediffersAGE = binom.test(x = OffendersWithViolenceAndAgeCrossover, n = NumberOfAgeCrossoverOffenders, p = ProportionOffendersWithViolenceAndNoAgeCrossover, alternative = c("two.sided"), conf.level = 0.95)

#Find p-values from the tests
p_valviolencediffersGENDER <- BinomtestviolencediffersGENDER$p.value
p_valviolencediffersRELATIONSHIP <- BinomtestviolencediffersRELATIONSHIP$p.value
p_valviolencediffersAGE <- BinomtestviolencediffersAGE$p.value
p_valuesviolencediffers <- c(p_valviolencediffersGENDER, p_valviolencediffersRELATIONSHIP, p_valviolencediffersAGE)

# Apply Holm-Bonferroni correction
ViolencediffersAdjusted_p_values <- p.adjust(p_valuesviolencediffers, method = "holm")

# Save output to file

write(paste("BinomtestviolencediffersGENDER: ", toString(BinomtestviolencediffersGENDER)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("BinomtestviolencediffersRELATIONSHIP: ", toString(BinomtestviolencediffersRELATIONSHIP)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("BinomtestviolencediffersAGE: ", toString(BinomtestviolencediffersAGE)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Violence differs: Holm-Bonferroni adjusted p-values for gender, relationship and age crossover: ", toString(ViolencediffersAdjusted_p_values)), "output/DataOnCrossoverOffenders.txt", append = TRUE)

# Testing if number of offenders who have injured at least one victim is greater for crossover offenders compared with specialized offenders
BinomtestviolencegreaterGENDER = binom.test(x = OffendersWithViolenceAndGenderCrossover, n = NumberOfGenderCrossoverOffenders, p = ProportionOffendersWithViolenceAndNoGenderCrossover, alternative = c("greater"), conf.level = 0.95)
BinomtestviolencegreaterRELATIONSHIP = binom.test(x = OffendersWithViolenceAndRelationshipCrossover, n = NumberOfRelationshipCrossoverOffenders, p = ProportionOffendersWithViolenceAndNoRelationshipCrossover, alternative = c("greater"), conf.level = 0.95)
BinomtestviolencegreaterAGE = binom.test(x = OffendersWithViolenceAndAgeCrossover, n = NumberOfAgeCrossoverOffenders, p = ProportionOffendersWithViolenceAndNoAgeCrossover, alternative = c("greater"), conf.level = 0.95)

#Find p-values from the tests
p_valviolencegreaterGENDER <- BinomtestviolencegreaterGENDER$p.value
p_valviolencegreaterRELATIONSHIP <- BinomtestviolencegreaterRELATIONSHIP$p.value
p_valviolencegreaterAGE <- BinomtestviolencegreaterAGE$p.value
p_valuesviolencegreater <- c(p_valviolencegreaterGENDER, p_valviolencegreaterRELATIONSHIP, p_valviolencegreaterAGE)


# Apply Holm-Bonferroni correction
ViolencegreaterAdjusted_p_values <- p.adjust(p_valuesviolencegreater, method = "holm")

# Save output to file hypothesis that violence is greater
write(paste("BinomtestviolencegreaterGENDER: ", toString(BinomtestviolencegreaterGENDER)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("BinomtestviolencegreaterRELATIONSHIP: ", toString(BinomtestviolencegreaterRELATIONSHIP)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("BinomtestviolencegreaterAGE: ", toString(BinomtestviolencegreaterAGE)), "output/DataOnCrossoverOffenders.txt", append = TRUE)
write(paste("Violence greater: Holm-Bonferroni adjusted p-values for gender, relationship and age crossover: ", toString(ViolencegreaterAdjusted_p_values)), "output/DataOnCrossoverOffenders.txt", append = TRUE)

#Save output to file: crossover statistics
file.create("output/OffenderAndCrossoverNumbers.txt")
write(paste("Total number of offenders including offenders with only one victim: ", toString(TotalOffendersIncludingOnlyOneOffence)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Total number of serial offenders: ", toString(TotalOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Number of female serial offenders: ", toString(FemaleSerialOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Proportion of female serial offenders: ", toString(ProportionOfFemaleSerialOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Number of male serial offenders: ", toString(MaleSerialOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Proportion of male serial offenders: ", toString(ProportionOfMaleSerialOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Number of unknown gender serial offenders: ", toString(UnknownGenderSerialOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Proportion of unknown gender serial offenders: ", toString(ProportionOfUnknownGenderSerialOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Number of gender crossover offenders: ", toString(NumberOfGenderCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Proportion of gender crossover offenders: ", toString(ProportionOfGenderCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Number of age crossover offenders: ", toString(NumberOfAgeCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Proportion of age crossover offenders: ", toString(ProportionOfAgeCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Number of relationship crossover offenders: ", toString(NumberOfRelationshipCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Proportion of relationship crossover offenders: ", toString(ProportionOfRelationshipCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Number of gender and age crossover offenders: ", toString(NumberOfGenderAndAgeCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Proportion of gender and age crossover offenders: ", toString(ProportionOfGenderAndAgeCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Number of gender and relationship crossover offenders: ", toString(NumberOfGenderAndRelationshipCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Proportion of gender and relationship crossover offenders: ", toString(ProportionOfGenderAndRelationshipCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Number of age and relationship crossover offenders: ", toString(NumberOfAgeAndRelationshipCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Proportion of age and relationship crossover offenders: ", toString(ProportionOfAgeAndRelationshipCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Number of gender, age and relationship crossover offenders: ", toString(NumberOfGenderAgeAndRelationshipCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)
write(paste("Proportion of gender, age and relationship crossover offenders: ", toString(ProportionOfGenderAgeAndRelationshipCrossoverOffenders)), "output/OffenderAndCrossoverNumbers.txt", append = TRUE)

file.create("output/overlapdatatable.txt")
write.table(overlapdatatable, "output/overlapdatatable.txt", append = FALSE, sep = ",", dec = ".", row.names = TRUE, col.names = TRUE)

file.create("output/offenderstatistics.csv")
write.table(OffenderStatisticsNoPersonalNumber, "output/offenderstatistics.csv", append = FALSE, sep = ";", dec = ".", row.names = FALSE, col.names = TRUE)

write.csv(SerialOffenderStatistics, file = "output/SerialOffenderStatistics1.csv", row.names = FALSE)

file.create("serialoffenderstatistics2.csv")
write.table(SerialOffenderStatisticsNoPersonalNumber, "output/serialoffenderstatistics.csv", append = FALSE, sep = ";", dec = ".", row.names = FALSE, col.names = TRUE)
#-----------------------------------
