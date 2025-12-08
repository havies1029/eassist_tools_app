part of 'dnsppacari_bloc.dart';

abstract class DnsppaCariEvents extends Equatable {
	const DnsppaCariEvents();

	@override
	List<Object> get props => [];
}

class FetchDnsppaCariEvent extends DnsppaCariEvents {}

class RefreshDnsppaCariEvent extends DnsppaCariEvents {
  final String cobId;
  final String currId;
  final String searchText;
  const RefreshDnsppaCariEvent(
    {
      this.cobId = "",
      this.currId = "",
      this.searchText = "",
    });
  @override
  List<Object> get props => [cobId, currId, searchText];
}

