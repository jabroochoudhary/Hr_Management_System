import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

const blueGradient = LinearGradient(
  colors: [
    Color(0XFF2bbefe),
    Color(0XFF6399ff),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);
const darkRedGradient = LinearGradient(
  colors: [
    Color(0XFFdd526b),
    Color(0XFFf8b699),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);
const tealGradient = LinearGradient(
  colors: [
    Color(0XFF199786),
    Color(0XFF74d9d0),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);
const redGradient = LinearGradient(
  colors: [
    Color(0XFFA7462C),
    Color(0XFFFD8B66),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);
const purpleGradient = LinearGradient(
  colors: [
    Color(0XFF71489D),
    Color(0XFFAA6DEC),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);
const yellowGradient = LinearGradient(
  colors: [
    Color(0XFFFFAF44),
    Color(0XFFFDD640),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

class LoanComponents {
  menuItem(
    BuildContext context,
    String title,
    LinearGradient gradient, {
    GestureTapCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: MediaQuery.of(context).size.width * 0.35,
        width: MediaQuery.of(context).size.width * 0.26,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: gradient,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "Rs.",
                  style: GoogleFonts.antonio(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  title(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey[900],
      ),
    );
  }

  introCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.fill,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(143, 148, 251, .2),
              blurRadius: 20.0,
              offset: Offset(0, 10),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Loan Advance',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Fast,easy,secure \nlow prime rate.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Explore',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 19,
                ),
              ),
              // SizedBox(width: 8),
              Lottie.asset("assets/arrow.json", height: 30),
              // Icon(FontAwesomeIcons.longArrowAltRight,
              //     size: 36, color: Colors.white),
            ],
          )
        ],
      ),
    );
  }
}
