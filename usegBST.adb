with gBST;
with Ada.Text_IO; use Ada.Text_IO;

procedure usegBST is

	type string10 is new String(1..10);

	type Customer is 
		record
			Name: string10;
			PhoneNumber: string10;
		end record;

	function "<"(TheKey: in string10; ARecord: in Customer)
		return Boolean is
	begin
		if TheKey < ARecord.Name then
			return true;
		else
			return false;
		end if;
	end;
	
	function ">"(TheKey: in string10; ARecord: in Customer)
		return Boolean is
	begin
		if TheKey > ARecord.Name then
			return true;
		else
			return false;
		end if;
	end;
	
	function "="(TheKey: in string10; ARecord: in Customer)
		return Boolean is
	begin
		if TheKey = ARecord.Name then
			return true;
		else
			return false;
		end if;
	end;
	
	procedure print(ARecord: in out Customer) is
	begin
		for i in 1..10 loop
			put(ARecord.Name(i));
		end loop;
	end print;

	
	procedure fillCustomerFields(ARecord: in out Customer; name: string10; phone: string10) is
	begin
		ARecord.Name := name;
		ARecord.PhoneNumber := phone;
	end;
	
	package go is new gBST(string10, Customer, "<", ">", "=", fillCustomerFields, print);
	use go;
	
begin
	null;
end usegBST;