                                            /***** Tp Final Rocking Data Esteban Otero******/

/* Comienzo limpiando las columnas Worksite_state_full & Worksite_state_abb para luego crear la tabla de dimensiones States*/

Update tp_rd.staging_visas
Set Worksite_state_abb = 'IL'
Where Worksite_state_full= 'ILLINOIS';

Update tp_rd.staging_visas
Set Worksite_state_abb = 'IN'
Where Worksite_state_full= 'INDIANA';

Update tp_rd.staging_visas
Set Worksite_state_abb = 'MI'
Where Worksite_state_full= 'MICHIGAN';

Update tp_rd.staging_visas
Set Worksite_state_abb = 'NY'
Where Worksite_state_full= 'NEW YORK';

Update tp_rd.staging_visas
Set Worksite_state_abb = 'OH'
Where Worksite_state_full= 'OHIO';

Update tp_rd.staging_visas
Set Worksite_state_abb = 'PA'
Where Worksite_state_full= 'PENNSYLVANIA';

Update tp_rd.staging_visas
Set Worksite_state_abb = 'WI'
Where Worksite_state_full= 'WISCONSIN';

Update tp_rd.staging_visas
Set Worksite_state_abb = 'MN'
Where Worksite_state_full= 'MINNESOTA';

Create table States as
Select Worksite_state_full as State_Name,
		Worksite_state_abb as State,
        avg(prevailing_wage) as Sueldo_promedio,
        Max(prevailing_wage) as Sueldo_Max,
        Min(prevailing_wage) as Sueldo_Min
From tp_rd.staging_visas
group by Worksite_state_full,Worksite_state_abb;

-- Le agrego 2 columnas (lat y long) para poder graficarla en un mapa si quisiese

Alter table States
add column Latitud DECIMAL(20,7),
add column Longitud DECIMAL(20,7),
add Primary key (state);       

Update States
Set Latitud = 40.0796606,
	Longitud= -89.4337288
Where state= 'IL';

Update States
Set Latitud = 40.2253569,
	Longitud= -82.6881395
Where state= 'OH';

Update States
Set Latitud = 45.9896587,
	Longitud= -94.6113288
Where state= 'MN';

Update States
Set Latitud = 40.3270127,
	Longitud= -86.1746933
Where state= 'IN';

Update States
Set Latitud = 43.6211955,
	Longitud= -84.6824346
Where state= 'MI';

Update States
Set Latitud = 40.7127281,
	Longitud= -74.0060152
Where state= 'NY';

Update States
Set Latitud = 44.4308975,
	Longitud= -89.6884637
Where state= 'WI';

Update States
Set Latitud = 40.9699889,
	Longitud= -77.7278831
Where state= 'PA';

/* Limpio las columnas Soc_Code & Soc_Name para luego crear la tabla de dimensiones Occupation */

Update tp_rd.staging_visas
Set Soc_Name = 'SOFTWARE DEVELOPERS, APPLICATIONS'
Where Soc_Code= 'SOFTWARE DEVELOPERS, APPLICATIONS';

Update tp_rd.staging_visas
Set Soc_Code= '15-1132'
Where Soc_Name like 'SOFTWARE DEVELOPERS, APPLICATIONS';

Update tp_rd.staging_visas
Set Soc_Name = 'OPERATIONS RESEARCH ANALYSTS'
Where Soc_Code= 'OPERATIONS RESEARCH ANALYSTS';

Update tp_rd.staging_visas
Set Soc_Code= '15-2031'
Where Soc_Name like 'OPERATIONS RESEARCH ANALYSTS';

Update tp_rd.staging_visas
Set Soc_Name = 'MECHANICAL ENGINEERS'
Where Soc_Code= 'MECHANICAL ENGINEERS';

Update tp_rd.staging_visas
Set Soc_Code= '17-2141'
Where Soc_Name like 'MECHANICAL ENGINEERS';

Update tp_rd.staging_visas
Set Soc_Name = 'COMPUTER SYSTEMS ANALYSTS'
Where Soc_Code= 'COMPUTER SYSTEMS ANALYSTS' or Soc_Code= '15-1121';

Update tp_rd.staging_visas
Set Soc_Code= '15-1121'
Where Soc_Name like 'COMPUTER SYSTEMS ANALYSTS' or Soc_Name='15-1121';

Update tp_rd.staging_visas
Set Soc_Code= left(Soc_Code,7)
where CHAR_LENGTH(Soc_Code)>7;

Update tp_rd.staging_visas
Set Soc_Code= concat(left(Soc_Code,2),'-', right(Soc_Code,4))
where Soc_Code NOT LIKE '%-%';

delete from tp_rd.staging_visas
where Soc_Code LIKE '%.%' or CHAR_LENGTH(Soc_Code)<7 ;

Update tp_rd.staging_visas
set Soc_Name = 'GENERAL AND OPERATIONS MANAGERS'
Where Soc_Code= '11-1021';

Update tp_rd.staging_visas
set Soc_Name = 'MARKETING MANAGERS'
Where Soc_Code= '11-2021';

Update tp_rd.staging_visas
set Soc_Name = 'PUBLIC RELATIONS AND FUNDRAISING MANAGERS'
Where Soc_Code= '11-2031';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER AND INFORMATION SYSTEMS MANAGERS'
Where Soc_Code= '11-3021';

Update tp_rd.staging_visas
set Soc_Name = 'FINANCIAL MANAGERS'
Where Soc_Code= '11-3031';

Update tp_rd.staging_visas
set Soc_Name = 'INDUSTRIAL PRODUCTIONS MANAGERS'
Where Soc_Code= '11-3051';

Update tp_rd.staging_visas
set Soc_Name = 'LOGISTICS MANAGERS'
Where Soc_Code= '11-3071';

Update tp_rd.staging_visas
set Soc_Name = 'COMPENSATION AND BENEFITS MANAGERS'
Where Soc_Code= '11-3111';

Update tp_rd.staging_visas
set Soc_Name = 'FARMERS, RANCHERS, AND OTHER AGRICULTURAL MANAGERS'
Where Soc_Code= '11-9013';

Update tp_rd.staging_visas
set Soc_Name = 'CONSTRUCTION MANAGERS'
Where Soc_Code= '11-9021';

Update tp_rd.staging_visas
set Soc_Name = 'EDUCATION ADMINISTRATORS, PRESCHOOL AND CHILDCARE'
Where Soc_Code= '11-9031';

Update tp_rd.staging_visas
set Soc_Name = 'EDUCATION ADMINISTRATORS, ELEMENTARY AND SECONDARY SCHOOL'
Where Soc_Code= '11-9032';

Update tp_rd.staging_visas
set Soc_Name = 'EDUCATION ADMINISTRATORS, POSTSECONDARY'
Where Soc_Code= '11-9033';

Update tp_rd.staging_visas
set Soc_Name = 'EDUCATION ADMINISTRATORS, ALL OTHER'
Where Soc_Code= '11-9039';

Update tp_rd.staging_visas
set Soc_Name = 'ARCHITECTURAL AND ENGINEERING MANAGERS'
Where Soc_Code= '11-9041';

Update tp_rd.staging_visas
set Soc_Name = 'LODGING MANAGERS'
Where Soc_Code= '11-9081';

Update tp_rd.staging_visas
set Soc_Name = 'MEDICAL AND HEALTH SERVICES MANAGERS'
Where Soc_Code= '11-9111';

Update tp_rd.staging_visas
set Soc_Name = 'CLINICAL RESEARCH COORDINATORS'
Where Soc_Code= '11-9121';

Update tp_rd.staging_visas
set Soc_Name = 'PROPERTY, REAL ESTATE AND COMMUNITY ASSOCIATION MANAGERS'
Where Soc_Code= '11-9141';

Update tp_rd.staging_visas
set Soc_Name = 'MANAGERS, ALL OTHER'
Where Soc_Code= '11-9199';

Update tp_rd.staging_visas
set Soc_Name = 'AGENTS AND BUSINESS MANAGERS OF ARTISTS, PERFORMERS, AND ATHLETES'
Where Soc_Code= '13-1011';

Update tp_rd.staging_visas
set Soc_Name = 'PURCHASING AGENTS, EXCEPT WHOLESALE, RETAIL, AND FARM PRODUCTS'
Where Soc_Code= '13-1023';

Update tp_rd.staging_visas
set Soc_Name = 'CLAIMS ADJUSTERS, EXAMINERS, AND INVESTIGATORS'
Where Soc_Code= '13-1031';

Update tp_rd.staging_visas
set Soc_Name = 'COMPLIANCE OFFICERS'
Where Soc_Code= '13-1041';

Update tp_rd.staging_visas
set Soc_Name = 'HUMAN RESOURCES SPECIALISTS'
Where Soc_Code= '13-1071';

Update tp_rd.staging_visas
set Soc_Name = 'LOGISTICS ENGINEERS'
Where Soc_Code= '13-1081';

Update tp_rd.staging_visas
set Soc_Name = 'MANAGEMENT ANALYSTS'
Where Soc_Code= '13-1111';

Update tp_rd.staging_visas
set Soc_Name = 'MEETING, CONVENTION, AND EVENT PLANNERS'
Where Soc_Code= '13-1121';

Update tp_rd.staging_visas
set Soc_Name = 'COMPENSATION, BENEFITS, AND JOB ANALYSIS SPECIALISTS'
Where Soc_Code= '13-1141';

Update tp_rd.staging_visas
set Soc_Name = 'TRAINING AND DEVELOPMENT SPECIALISTS'
Where Soc_Code= '13-1151';

Update tp_rd.staging_visas
set Soc_Name = 'MARKET RESEARCH ANALYSTS AND MARKETING SPECIALISTS'
Where Soc_Code= '13-1161';

Update tp_rd.staging_visas
set Soc_Name = 'BUSINESS OPERATIONS SPECIALISTS, ALL OTHER'
Where Soc_Code= '13-1199';

Update tp_rd.staging_visas
set Soc_Name = 'ACCOUNTANTS AND AUDOTORS'
Where Soc_Code= '13-2011';

Update tp_rd.staging_visas
set Soc_Name = 'CREDIT ANALYST'
Where Soc_Code= '13-2041';

Update tp_rd.staging_visas
set Soc_Name = 'FINANCIAL ANALYSTS'
Where Soc_Code= '13-2051';

Update tp_rd.staging_visas
set Soc_Name = 'FINANCIAL SPECIALISTS, ALL OTHER'
Where Soc_Code= '13-2099';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER PROGRAMMERS, NON R&D'
Where Soc_Code= '15-1022';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER PROGRAMMERS, R&D'
Where Soc_Code= '15-1023';

Update tp_rd.staging_visas
set Soc_Name = 'SOFTWARE DEVELOPERS, APPLICATIONS, NON R&D'
Where Soc_Code= '15-1034';

Update tp_rd.staging_visas
set Soc_Name = 'SOFTWARE DEVELOPERS, APPLICATIONS, R&D'
Where Soc_Code= '15-1035';

Update tp_rd.staging_visas
set Soc_Name = 'SOFTWARE DEVELOPERS, SYSTEMS SOFTWARE, NON R&D'
Where Soc_Code= '15-1036';

Update tp_rd.staging_visas
set Soc_Name = 'SOFTWARE DEVELOPERS, SYSTEMS SOFTWARE, R&D'
Where Soc_Code= '15-1037';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER SYSTEMS ANALYSTS, NON R&D'
Where Soc_Code= '15-1052';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER SYSTEMS ANALYSTS, R&D'
Where Soc_Code= '15-1053';

Update tp_rd.staging_visas
set Soc_Name = 'BUSINESS INTELLIGENCE ANALYSTS'
Where Soc_Code= '15-1099';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER AND INFORMATION RESEARCH SCIENTISTS'
Where Soc_Code= '15-1111';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER SYSTEMS ANALYSTS'
Where Soc_Code= '15-1121';

Update tp_rd.staging_visas
set Soc_Name = 'INFORMATION SECURITY ANALYSTS'
Where Soc_Code= '15-1122';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER PROGRAMMERS'
Where Soc_Code= '15-1131';

Update tp_rd.staging_visas
set Soc_Name = 'SOFTWARE DEVELOPERS, APPLICATIONS'
Where Soc_Code= '15-1132';

Update tp_rd.staging_visas
set Soc_Name = 'SOFTWARE DEVELOPERS, SYSTEMS SOFTWARE'
Where Soc_Code= '15-1133';

Update tp_rd.staging_visas
set Soc_Name = 'WEB DEVELOPERS'
Where Soc_Code= '15-1134';

Update tp_rd.staging_visas
set Soc_Name = 'DATABASE ADMINISTRATORS'
Where Soc_Code= '15-1141';

Update tp_rd.staging_visas
set Soc_Name = 'NETWORK AND COMPUTER SYSTEMS ADMINISTRATORS'
Where Soc_Code= '15-1142';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER NETWORK ARCHITECTS'
Where Soc_Code= '15-1143';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER SUPPORT SPECIALISTS'
Where Soc_Code= '15-1150';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER NETWORK SUPPORT SPECIALISTS'
Where Soc_Code= '15-1152';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER SYSTEMS ENGINEERS/ARCHITECTS'
Where Soc_Code= '15-1191';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER APPLICATIONS, ALL OTHERS'
Where Soc_Code= '15-1199';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER OCCUPATIONS, ALL OTHER'
Where Soc_Code= '15-1799';

Update tp_rd.staging_visas
set Soc_Name = 'MATHEMATICIANS'
Where Soc_Code= '15-2021';

Update tp_rd.staging_visas
set Soc_Name = 'OPERATIONS RESEARCH ANALYSTS'
Where Soc_Code= '15-2031';

Update tp_rd.staging_visas
set Soc_Name = 'STATISTICIANS'
Where Soc_Code= '15-2041';

Update tp_rd.staging_visas
set Soc_Name = 'ARCHITECTS, EXCEPT LANDSCAPE AND NAVAL'
Where Soc_Code= '17-1011';

Update tp_rd.staging_visas
set Soc_Name = 'BIOMEDIAL ENGINEERS'
Where Soc_Code= '17-2031';

Update tp_rd.staging_visas
set Soc_Name = 'CHEMICAL ENGINEERS'
Where Soc_Code= '17-2041';

Update tp_rd.staging_visas
set Soc_Name = 'CIVIL ENGINEERS'
Where Soc_Code= '17-2051';

Update tp_rd.staging_visas
set Soc_Name = 'CIVIL ENGINEERS, NON R&D'
Where Soc_Code= '17-2052';

Update tp_rd.staging_visas
set Soc_Name = 'CIVIL ENGINEERS, R&D'
Where Soc_Code= '17-2053';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER HARDWARE ENGINEERS'
Where Soc_Code= '17-2061';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER HARDWARE ENGINEERS, NON R&D'
Where Soc_Code= '17-2062';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER HARDWARE ENGINEERS, R&D'
Where Soc_Code= '17-2063';

Update tp_rd.staging_visas
set Soc_Name = 'ELECTRICAL ENGINEERS'
Where Soc_Code= '17-2071';

Update tp_rd.staging_visas
set Soc_Name = 'ELECTRONICS ENGINEERS, EXCEPT COMPUTERS'
Where Soc_Code= '17-2072';

Update tp_rd.staging_visas
set Soc_Name = 'ELECTRICAL ENGINEERS, NON R&D'
Where Soc_Code= '17-2073';

Update tp_rd.staging_visas
set Soc_Name = 'ELECTRICAL ENGINEERS, R&D'
Where Soc_Code= '17-2074';

Update tp_rd.staging_visas
set Soc_Name = 'ELECTRONICS ENGINEERS, EXCEPT COMPUTER, NON-R&D'
Where Soc_Code= '17-2075';

Update tp_rd.staging_visas
set Soc_Name = 'ELECTRONICS ENGINEERS, EXCEPT COMPUTER, R&D'
Where Soc_Code= '17-2076';

Update tp_rd.staging_visas
set Soc_Name = 'ENVIRONMENTAL ENGINEERS'
Where Soc_Code= '17-2081';

Update tp_rd.staging_visas
set Soc_Name = 'HEALTH AND SAFETY ENGINEERS, EXCEPT MINING SAFETY'
Where Soc_Code= '17-2111';

Update tp_rd.staging_visas
set Soc_Name = 'INDUSTRIAL ENGINEERS'
Where Soc_Code= '17-2112';

Update tp_rd.staging_visas
set Soc_Name = 'MATERIALS ENGINEERS'
Where Soc_Code= '17-2131';

Update tp_rd.staging_visas
set Soc_Name = 'MECHANICAL ENGINEERS'
Where Soc_Code= '17-2141';

Update tp_rd.staging_visas
set Soc_Name = 'MECHANICAL ENGINEERS, NON R&D'
Where Soc_Code= '17-2143';

Update tp_rd.staging_visas
set Soc_Name = 'MECHANICAL ENGINEERS, R&D'
Where Soc_Code= '17-2144';

Update tp_rd.staging_visas
set Soc_Name = 'MINING AND GEOLOGICAL ENGINEERS, INCLUDING MINING SAFETY ENGINEERS'
Where Soc_Code= '17-2151';

Update tp_rd.staging_visas
set Soc_Name = 'ENGINEERS, ALL OTHERS'
Where Soc_Code= '17-2199';

Update tp_rd.staging_visas
set Soc_Name = 'ARCHITECTURAL AND CIVIL DRAFTERS'
Where Soc_Code= '17-3011';

Update tp_rd.staging_visas
set Soc_Name = 'ELECTRICAL AND ELECTRONIC ENGINEERING TECHNICIANS'
Where Soc_Code= '17-3023';

Update tp_rd.staging_visas
set Soc_Name = 'ENGINEERING TECHNICIANS, EXCEPT DRAFTERS, ALL OTHER'
Where Soc_Code= '17-3029';

Update tp_rd.staging_visas
set Soc_Name = 'FOOD SCIENTISTS AND TECHNOLOGISTS'
Where Soc_Code= '19-1012';

Update tp_rd.staging_visas
set Soc_Name = 'SOIL AND PLANT SCIENTISTS'
Where Soc_Code= '19-1013';

Update tp_rd.staging_visas
set Soc_Name = 'BIOCHEMISTS OR BIOPHYSICISTS'
Where Soc_Code= '19-1021';

Update tp_rd.staging_visas
set Soc_Name = 'BIOLOGICAL SCIENTISTS, ALL OTHER'
Where Soc_Code= '19-1029';

Update tp_rd.staging_visas
set Soc_Name = 'EPIDEMIOLOGISTS'
Where Soc_Code= '19-1041';

Update tp_rd.staging_visas
set Soc_Name = 'MEDICAL SCIENTISTS, EXCEPT EPIDEMIOLOGISTS'
Where Soc_Code= '19-1042';

Update tp_rd.staging_visas
set Soc_Name = 'PHYSICISTS'
Where Soc_Code= '19-2012';

Update tp_rd.staging_visas
set Soc_Name = 'CHEMISTS'
Where Soc_Code= '19-2031';

Update tp_rd.staging_visas
set Soc_Name = 'MATERIALS SCIENTISTS'
Where Soc_Code= '19-2032';

Update tp_rd.staging_visas
set Soc_Name = 'ENVIRONMENTAL SCIENTISTS AND SPECIALISTS, INCLUDING HEALTH'
Where Soc_Code= '19-2041';

Update tp_rd.staging_visas
set Soc_Name = 'GEOSCIENTISTS, EXCEPT HYDROLOGISTS AND GEOGRAPHERS'
Where Soc_Code= '19-2042';

Update tp_rd.staging_visas
set Soc_Name = 'PHYSICAL SCIENTISTS, ALL OTHER'
Where Soc_Code= '19-2099';

Update tp_rd.staging_visas
set Soc_Name = 'ECONOMISTS'
Where Soc_Code= '19-3011';

Update tp_rd.staging_visas
set Soc_Name = 'PSYCHOLOGISTS, ALL OTHER'
Where Soc_Code= '19-3039';

Update tp_rd.staging_visas
set Soc_Name = 'SOCIAL SCIENTISTS AND RELATED WORKERS, ALL OTHER'
Where Soc_Code= '19-3099';

Update tp_rd.staging_visas
set Soc_Name = 'BIOLOGICAL TECHNICIANS'
Where Soc_Code= '19-4021';

Update tp_rd.staging_visas
set Soc_Name = 'ENVIRONMENTAL SCIENCE AND PROTECTION TECHNICIANS, INCLUDING HEALTH'
Where Soc_Code= '19-4091';

Update tp_rd.staging_visas
set Soc_Name = 'LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS, ALL OTHER'
Where Soc_Code= '19-4099';

Update tp_rd.staging_visas
set Soc_Name = 'EDUCATIONAL, GUIDANCE, SCHOOL, AND VOCATIONAL COUNSELORS'
Where Soc_Code= '21-1012';

Update tp_rd.staging_visas
set Soc_Name = 'MENTAL HEALTH COUNSELORS'
Where Soc_Code= '21-1014';

Update tp_rd.staging_visas
set Soc_Name = 'REHABILITATION COUNSELORS'
Where Soc_Code= '21-1015';

Update tp_rd.staging_visas
set Soc_Name = 'PROBATION OFFICERS AND CORRECTIONAL TREATMENT SPECIALISTS'
Where Soc_Code= '21-1092';

Update tp_rd.staging_visas
set Soc_Name = 'COMMUNITY AND SOCIAL SERVICE SPECIALISTS, ALL OTHER'
Where Soc_Code= '21-1099';

Update tp_rd.staging_visas
set Soc_Name = 'LAWYERS'
Where Soc_Code= '23-1011';

Update tp_rd.staging_visas
set Soc_Name = 'JUDICIAL LAW CLERKS'
Where Soc_Code= '23-1012';

Update tp_rd.staging_visas
set Soc_Name = 'PARALEGALS AND LEGAL ASSISTANTS'
Where Soc_Code= '23-2011';

Update tp_rd.staging_visas
set Soc_Name = 'LEGAL SUPPORT WORKERS, ALL OTHER'
Where Soc_Code= '23-2099';

Update tp_rd.staging_visas
set Soc_Name = 'BUSINESS TEACHERS, POSTSECONDARY'
Where Soc_Code= '25-1011';

Update tp_rd.staging_visas
set Soc_Name = 'COMPUTER SCIENCE TEACHERS, POST-SECONDARY'
Where Soc_Code= '25-1021';

Update tp_rd.staging_visas
set Soc_Name = 'MATHEMATICAL SCIENCE TEACHERS, POSTSECONDARY'
Where Soc_Code= '25-1022';

Update tp_rd.staging_visas
set Soc_Name = 'ENGINEERING TEACHERS, POSTSECONDARY'
Where Soc_Code= '25-1032';

Update tp_rd.staging_visas
set Soc_Name = 'FORESTRY AND CONSERVATION SCIENCE TEACHERS, POSTSECONDARY'
Where Soc_Code= '25-1043';

Update tp_rd.staging_visas
set Soc_Name = 'ATMOSPHERIC, EARTH, MARINE, AND SPACE SCIENCES TEACHERS, POSTSECONDARY'
Where Soc_Code= '25-1051';

Update tp_rd.staging_visas
set Soc_Name = 'ANTHROPOLOGY AND ARCHEOLOGY TEACHERS, POSTSECONDAR'
Where Soc_Code= '25-1061';

Update tp_rd.staging_visas
set Soc_Name = 'AREA, ETHNIC, AND CULTURAL STUDIES TEACHERS, POSTSECONDARY'
Where Soc_Code= '25-1062';

Update tp_rd.staging_visas
set Soc_Name = 'SOCIAL SCIENCES TEACHERS, POSTSECONDARY, ALL OTHER'
Where Soc_Code= '25-1069';

Update tp_rd.staging_visas
set Soc_Name = 'HEALTH SPECIALTIES TEACHERS, POSTSECONDARY'
Where Soc_Code= '25-1071';

Update tp_rd.staging_visas
set Soc_Name = 'CRIMINAL JUSTICE AND LAW ENFORCEMENT TEACHERS, POSTSECONDARY'
Where Soc_Code= '25-1111';

Update tp_rd.staging_visas
set Soc_Name = 'COMMUNICATIONS STUDIES TEACHERS, POSTSECONDARY'
Where Soc_Code= '25-1122';

Update tp_rd.staging_visas
set Soc_Name = 'ENGLISH LANGUAGE & LITERATURE TEACHERS, POSTSECOND'
Where Soc_Code= '25-1123';

Update tp_rd.staging_visas
set Soc_Name = 'FOREIGN LANGUAGE & LITERATURE TEACHERS, POSTSECOND'
Where Soc_Code= '25-1124';

Update tp_rd.staging_visas
set Soc_Name = 'RECREATION AND FITNESS STUDIES TEACHERS, POSTSECONDARY'
Where Soc_Code= '25-1193';

Update tp_rd.staging_visas
set Soc_Name = 'POSTSECONDARY TEACHERS, ALL OTHER'
Where Soc_Code= '25-1199';

Update tp_rd.staging_visas
set Soc_Name = 'ELEMENTARY SCHOOL TEACHERS, EXCEPT SPECIAL EDUCATION'
Where Soc_Code= '25-2021';

Update tp_rd.staging_visas
set Soc_Name = 'MIDDLE SCHOOL TEACHERS, EXCEPT SPECIAL AND CAREER/TECHNICAL EDUCATION'
Where Soc_Code= '25-2022';

Update tp_rd.staging_visas
set Soc_Name = 'CAREER/TECHNICAL EDUCATION TEACHERS, MIDDLE SCHOOL'
Where Soc_Code= '25-2023';

Update tp_rd.staging_visas
set Soc_Name = 'SECONDARY SCHOOL TEACHERS, EXCEPT SPECIAL AND CAREER/TECHNICAL EDUCATION'
Where Soc_Code= '25-2031';

Update tp_rd.staging_visas
set Soc_Name = 'SPECIAL EDUCATION TEACHERS, PRESCHOOL, KINDERGARTE'
Where Soc_Code= '25-2041';

Update tp_rd.staging_visas
set Soc_Name = 'SPECIAL EDUCATION TEACHERS, KINDERGARTEN AND ELEMENTARY SCHOOL'
Where Soc_Code= '25-2052';

Update tp_rd.staging_visas
set Soc_Name = 'ADULT BASIC AND SECONDARY EDUCATION AND LITERACY TEACHERS AND INSTRUCTORS'
Where Soc_Code= '25-3011';

Update tp_rd.staging_visas
set Soc_Name = 'AUDIO-VISUAL AND MULTIMEDIA COLLECTIONS SPECIALISTS'
Where Soc_Code= '25-9011';

Update tp_rd.staging_visas
set Soc_Name = 'EDUCATION, TRAINING, AND LIBRARY WORKERS, ALL OTHER'
Where Soc_Code= '25-9099';

Update tp_rd.staging_visas
Set Soc_Name = 'ART DIRECTORS'
Where Soc_Code= '27-1011';

Update tp_rd.staging_visas
Set Soc_Name = 'FINE ARTISTS, INCLUDING PAINTERS, SCULPTORS, AND ILLUSTRATORS'
Where Soc_Code= '27-1013';

Update tp_rd.staging_visas
Set Soc_Name = 'MULTIMEDIA ARTISTS AND ANIMATORS'
Where Soc_Code= '27-1014';

Update tp_rd.staging_visas
Set Soc_Name = 'COMMERCIAL AND INSDISTRIAL DESIGNERS'
Where Soc_Code= '27-1021';

Update tp_rd.staging_visas
Set Soc_Name = 'GRAPHIC DESIGNERS'
Where Soc_Code= '27-1024';

Update tp_rd.staging_visas
Set Soc_Name = 'INTERIOR DESIGNERS'
Where Soc_Code= '27-1025';

Update tp_rd.staging_visas
Set Soc_Name = 'DESIGNERS, ALL OTHERS'
Where Soc_Code= '27-1029';

Update tp_rd.staging_visas
Set Soc_Name = 'PRODUCERS AND DIRECTORS'
Where Soc_Code= '27-2012';

Update tp_rd.staging_visas
Set Soc_Name = 'COMMERCIAL AND INDUSTRIAL DESIGNERS'
Where Soc_Code= '27-2021';

Update tp_rd.staging_visas
Set Soc_Name = 'MUSICIANS AND SINGERS'
Where Soc_Code= '27-2042';

Update tp_rd.staging_visas
Set Soc_Name = 'ENTERTAINERS AND PERFORMERS, SPORTS, ALL OTHERS'
Where Soc_Code= '27-2099';

Create table Occupation as
Select SOC_CODE,
		SOC_Name
From tp_rd.staging_visas
group by SOC_CODE, SOC_Name;

Alter table Occupation
Add primary key(Soc_code);

/*Creo la tabla de dimensiones Employer */

Create table Employer as
Select EMPLOYER_NAME as Employer,
		WORKSITE_STATE_ABB as State
From tp_rd.staging_visas
group by EMPLOYER_NAME, WORKSITE_STATE_ABB;

Alter table Employer
Add Id_employer int not null auto_increment,
Add primary key (id_employer);

/* Creo una tabla con los estados de las solicitudes x año */

Create table Solicitudes_Fechas as
Select Year,
		Case_Status,
        Count(*)
From tp_rd.staging_visas
group by year, Case_status;

/* Por ultimo creo la tabla Facts "Visas" que es a la cual la voy a relacionar con el resto de las tablas de dimensiones que fui creando*/

Create table Visas as
Select Case_number,
		Case_Status,
        Id_employer,
        Soc_code,
        Job_title,
        Full_time_Position
        Prevaling_wage,
        Worksite_state_ABB as state,
        worksite,
        left(Soc_code,2) as vertical
From tp_rd.staging_visas
Join employer on employer.Employer=staging_visas.EMPLOYER_NAME ;

Alter table Visas
add column Id int Not null auto_increment,
add primary key (id),
add foreign key (state) References States(State),
add foreign key (id_employer) references Employer(id_employer),
Add foreign key (Soc_code) references Occupation(soc_code)

