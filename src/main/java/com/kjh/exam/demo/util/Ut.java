package com.kjh.exam.demo.util;

public class Ut {

	public static boolean empty(Object obj) {
		if (obj == null) {
			return true;
		}

		if (obj instanceof String == false) {
			return true;
		}

		String str = (String) obj;

		return str.trim().length() == 0;
	}

	public static String f(String format, Object... args) {

		return String.format(format, args);
	}

	public static String jsHistoryBack(String msg) {

		if (msg == null) {
			msg = "";
		}
		return Ut.f("""
				<script>
				alert('%s');
				history.back();
				</script>
				""", msg);
	}

	public static String jsReplace(String msg, String replaceUri) {

		if (msg == null) {
			msg = "";
		}
		if (replaceUri == null) {
			replaceUri = "";
		}
		return Ut.f("""
				<script>
				alert('%s');
				location.replace('%s');
				</script>
				""", msg, replaceUri);
	}
}
