FROM golang:1.24 as build-stage

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o go-web-app .

########## Final Image ##########

FROM gcr.io/distroless/base

COPY --from=build-stage /app/static ./static
COPY --from=build-stage /app/go-web-app .

ENTRYPOINT [ "./go-web-app" ]
