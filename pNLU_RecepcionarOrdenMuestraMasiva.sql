USE [NetLab2-Ogis]
GO
/****** Object:  StoredProcedure [dbo].[pNLU_RecepcionarOrdenMuestraMasiva]    Script Date: 12/07/2017 12:21:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*******************************************************************************  
Descripcion: Actualiza el regitro de la orden para recepcionarla - masivo.  
Creado por: SOTERO BUSTAMANTE  
Fecha Creacion: 26/11/2017  
Modificacion: Se agegaron comentarios.  
*******************************************************************************/  
ALTER PROCEDURE [dbo].[pNLU_RecepcionarOrdenMuestraMasiva]   

@Lista Varchar(max),
@idUsuario int
AS  
BEGIN  



 BEGIN TRANSACTION
	Declare Tabla Cursor For Select * From fnSplitString(@Lista,'|')
	
	Open Tabla
	Declare @Columna varchar(max)	
	declare @IdOrden uniqueidentifier		
	Declare @pos1 int
	
	
	Fetch Next From Tabla Into @Columna
	While @@FETCH_STATUS = 0
	Begin
	
	set @pos1 = CHARINDEX('-',@Columna,0) 
	set @IdOrden =  @Columna -- SUBSTRING(@Columna,1,@pos1-1)
	
				UPDATE OrdenMuestraRecepcion 
				  
				 SET  fechaLlegada = GETDATE(),   
					  horaLlegada = convert(varchar(10), GETDATE(), 108),
					  usuarioLlegada= @idUsuario  
				 WHERE idOrden = @IdOrden  
				
	Fetch Next From Tabla Into @Columna
	End
	Close Tabla;
	Deallocate Tabla;
	Commit Transaction
	
END


