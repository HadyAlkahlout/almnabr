import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/generic/generic_response.dart';

part 'receipient_reservation_response.g.dart';

@JsonSerializable()
class ReceipientReservationResponse {
  @JsonKey(name: 'noSetupWIRReceipientReservation')
  GenericResponse? noSetupWIRReceipientReservation;
  @JsonKey(name: 'wirReceipientReservation')
  GenericResponse? wirReceipientReservation;

  ReceipientReservationResponse();

  factory ReceipientReservationResponse.fromJson(Map<String, dynamic> json) =>
      _$ReceipientReservationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReceipientReservationResponseToJson(this);
}
