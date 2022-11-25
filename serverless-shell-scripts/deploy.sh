GOOGLE_PROJECT_ID=medical-portal-dev-ro

gcloud run deploy \
  --project $GOOGLE_PROJECT_ID \
  --platform managed \
  --region europe-west3 \
  --image europe-west4-docker.pkg.dev/h4h-global/general/shell-test:latest
  --no-allow-unauthenticated \
  my-shell-script
