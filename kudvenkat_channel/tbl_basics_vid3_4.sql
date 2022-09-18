-- A primary key is used to identify uniquely each record in a table.

create table tblGender
(
	ID int NOT NULL Primary Key,
	Gender nvarchar(50) Not Null,
)

create table tblPerson
(
	ID int NOT NULL Primary Key,
	Name nvarchar(50) NOT NULL,
	Email nvarchar(50) NOT NULL,
	GenderId int
)

-- Foreign Keys are used to enforce database integrity. In layman's terms, a foreign key in one table points to a primary key in another table.
-- The foreign key constraint prevents invalid data from being inserted into the foreign key column. The values that you enter into the foreign
-- key column, has to be one of the values contained in the table it points to.

-- Adding a foreign key

alter table tblPerson add constraint tblPerson_Gender_ID_FK
foreign key (GenderId)
references tblGender (ID)

select * from tblGender
select * from tblPerson

insert into tblPerson(ID, Name, Email) Values (7, 'Rich', 'r@r.com')

-- A column default can be specified using Default constraint. 
-- The DEFAULT constraint is used to insert a default value into a column.
-- The default value will be added to all new records, if no other value is specified, including NULL.

-- Adding a default
alter table tblPerson add constraint tblPerson_Gender_ID_DF
default 3 for GENDERID

-- Dropping a constraint 
-- alter table tblPerson drop constraint tblPerson_Gender_ID_DF

insert into tblPerson(ID, Name, Email) Values (8, 'Mike', 'mike@r.com')

insert into tblPerson(ID, Name, Email, GenderId) Values (9, 'Johny', 'j@r.com', NULL)