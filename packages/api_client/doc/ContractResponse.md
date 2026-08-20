# api_client.model.ContractResponse

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | [optional] 
**status** | **String** |  | [optional] 
**annonceId** | **String** |  | [optional] 
**annonceTitle** | **String** |  | [optional] 
**city** | **String** |  | [optional] 
**district** | **String** |  | [optional] 
**exactAddress** | **String** |  | [optional] 
**prestataire** | [**ParticipantSummary**](ParticipantSummary.md) |  | [optional] 
**tenant** | [**ParticipantSummary**](ParticipantSummary.md) |  | [optional] 
**agent** | [**ParticipantSummary**](ParticipantSummary.md) |  | [optional] 
**price** | **int** |  | [optional] 
**rentalPeriod** | **String** |  | [optional] 
**monthlyRent** | **int** |  | [optional] 
**depositAmount** | **int** |  | [optional] 
**chargesIncluded** | **bool** |  | [optional] 
**startDate** | [**Date**](Date.md) |  | [optional] 
**endDate** | [**Date**](Date.md) |  | [optional] 
**durationUnits** | **int** |  | [optional] 
**tacitRenewal** | **bool** |  | [optional] 
**signatures** | [**BuiltList&lt;SignatureResponse&gt;**](SignatureResponse.md) |  | [optional] 
**changeRequests** | [**BuiltList&lt;ChangeRequestResponse&gt;**](ChangeRequestResponse.md) |  | [optional] 
**awaiting** | **String** |  | [optional] 
**canSign** | **bool** |  | [optional] 
**residentReviewEligible** | **bool** |  | [optional] 
**lockedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | [optional] 
**updatedAt** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


