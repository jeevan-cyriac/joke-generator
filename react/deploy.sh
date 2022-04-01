rm -rf build
npm run build
AWS_PROFILE=training aws s3 sync build/ s3://jeevancyriac.com --delete