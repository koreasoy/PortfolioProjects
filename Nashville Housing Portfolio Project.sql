/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [Portfolio Project].[dbo].[NashvilleHousing]

  Select *
  From [Portfolio Project]..NashvilleHousing

   Select SaleDateConverted, CONVERT(Date,SaleDate)
  From [Portfolio Project]..NashvilleHousing

  Update NashvilleHousing
  SET SaleDate = CONVERT(Date,SaleDate)

  ALTER TABLE NashvilleHousing
  Add SaleDateConverted Date; 

   Update NashvilleHousing
  SET SaleDateConverted = CONVERT(Date,SaleDate)

Select *
  From [Portfolio Project]..NashvilleHousing
 -- Where PropertyAddress is null
 order by ParcelID

 Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Portfolio Project]..NashvilleHousing a
JOIN [Portfolio Project]..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND A.[UniqueID ]<> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Portfolio Project]..NashvilleHousing a
JOIN [Portfolio Project]..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND A.[UniqueID ]<> b.[UniqueID ]

Select PropertyAddress
  From [Portfolio Project]..NashvilleHousing
 -- Where PropertyAddress is null
 --order by ParcelID

 SELECT
 SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1 ) as Address
 , SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

 From [Portfolio Project]..NashvilleHousing


 ALTER TABLE NashvilleHousing
  Add PropertySplitAddress Nvarchar(255);

   Update NashvilleHousing
  SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1 )

  ALTER TABLE NashvilleHousing
  Add PropertySplitCity Nvarchar(255);

   Update NashvilleHousing
  SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

Select *
From [Portfolio Project]..NashvilleHousing



Select OwnerAddress
From [Portfolio Project]..NashvilleHousing


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From [Portfolio Project]..NashvilleHousing


 ALTER TABLE NashvilleHousing
  Add OwnerSplitAddress Nvarchar(255);

   Update NashvilleHousing
  SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

  ALTER TABLE NashvilleHousing
  Add OwnerSplitCity Nvarchar(255);

   Update NashvilleHousing
  SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

  ALTER TABLE NashvilleHousing
  Add OwnerSplitState Nvarchar(255);

   Update NashvilleHousing
  SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


Select *
From [Portfolio Project]..NashvilleHousing


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From [Portfolio Project]..NashvilleHousing
Group by SoldAsVacant
order by 2


Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	When SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END
From [Portfolio Project]..NashvilleHousing


Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	When SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END

WITH RowNumCTE AS(
Select *,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDate,
			LegalReference
			ORDER BY
			UniqueID
			) row_num


From [Portfolio Project]..NashvilleHousing
--order by ParcelID
)

DELETE
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress

Select *
From [Portfolio Project]..NashvilleHousing


ALTER TABLE [Portfolio Project]..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE [Portfolio Project]..NashvilleHousing
DROP COLUMN SaleDate