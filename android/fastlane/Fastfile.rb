default_platform(:android)

platform :android do
  desc "Build Flutter APK and upload to Firebase"
  lane :distribute_testing do |options|
    flavor = options[:flavor] || "staging"
    target = options[:target] || "lib/main_staging.dart"

    # Build Flutter APK
    Dir.chdir("../..") do
      sh("flutter pub get")
      sh("flutter build apk -t #{target} --flavor #{flavor}")

      # Upload to Firebase App Distribution
      firebase_app_distribution(
        app: ENV["FIREBASE_APP_ID_TESTING"],
        service_credentials_file: ENV["GOOGLE_APPLICATION_CREDENTIALS"],
        groups: "tester",
        release_notes: ENV["CI_COMMIT_MESSAGE"],
        # Mengarah ke folder output rilis secara default
        apk_path: "build/app/outputs/flutter-apk/app-#{flavor}-release.apk",
        debug: true
      )
    end
  end
end