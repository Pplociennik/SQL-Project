
--ile srednio jednostek towaru zostalo dostarczonych do magazyn�w miesi�cznie...
CREATE FUNCTION IleTowarow
(
	@towar_roczny INT
)
	RETURNS INT
AS
BEGIN

	RETURN @towar_roczny / 12
END;

SELECT dbo.IleTowarow(5679);	--dla 5679 jednostek towaru dostarczonego w roku?


--w magazynach o jakich numerach znajduj� si�...
CREATE FUNCTION Wmagazynie
(
	@towar VARCHAR(10)
)
	RETURNS TABLE

AS
	RETURN SELECT magazyn
			FROM Towary
				WHERE nazwa = @towar;


SELECT * FROM Wmagazynie('Wi�nie');	--wi�nie?

