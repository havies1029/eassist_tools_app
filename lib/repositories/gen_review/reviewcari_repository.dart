import 'package:eassist_tools_app/apis/gen_review/reviewcari_api.dart';
import 'package:eassist_tools_app/models/gen_review/reviewcari_model.dart';

class ReviewCariRepository {

	Future<List<ReviewCariModel>> getReviewCari(int hal) async {
		ReviewCariAPI api = ReviewCariAPI();
		return await api.getReviewCariAPI(hal);
	}
}
