Create procedure pNLS_ExamenByNombreAndLaboratorioAndTmuestra
@nombre varchar(50),
@idTipoMuestra int,
@idEnfermedad  int,  
@idLaboratorio int,    
@genero int    
AS    
BEGIN    
 SET NOCOUNT ON     
SELECT  e.idExamen,      
 'LOINC: '+isnull(CAST(LTRIM(RTRIM(LOINC)) AS VARCHAR(10)),'') +       
 ' - CPT: ' + isnull(CAST(LTRIM(RTRIM(CPT)) AS VARCHAR(8)),'')+      
 ' - '+ substring(LTRIM(RTRIM(DESCRIPCION)),0,30) as 'nombre'    ,         
 'LOINC: '+isnull(CAST(LTRIM(RTRIM(LOINC))   
AS VARCHAR(10)),'') +     ' - CPT: ' + isnull(CAST(LTRIM(RTRIM(CPT)) AS VARCHAR(8)),'')+      
' - '+ LTRIM(RTRIM(descripcion)) as 'descripcion' 

from Examen e
  inner join EnfermedadExamen ex
  on e.idExamen =  ex.idExamen
  inner join ExamenTipoMuestra em
  on e.idExamen = em.idExamen 
  inner join ExamenEstablecimiento ee
  on e.idExamen = ee.idExamen
  where idEnfermedad=@idEnfermedad and ee.idEstablecimiento=@idLaboratorio 
  and idTipoMuestra = @idTipoMuestra
  and LTRIM(RTRIM(e.descripcion)) LIKE '%'+LTRIM(RTRIM(@nombre))+'%'  
  AND (e.idGenero =  1  OR e.idGenero = 3) and e.estado = 1 

 END
