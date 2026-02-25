import asyncio
from faststream import FastStream, Context
from shared.stream.service import KafkaService
from shared.schemas.stream_schema import (
    RecommendationRequestPayload, 
    RecommendedItem,
    RecommendationResponseData, 
    RecommendationResponsePayload, 
    PersonaRequestPayload
)

service = KafkaService()
broker = service.broker
app = FastStream(broker)

# 추천 요청
@broker.subscriber(service.get_recommendation_request_topic())
async def handle_recommendation(event: RecommendationRequestPayload, message = Context()):
    print("get recommendation request")
    await asyncio.sleep(1)

    # TODO: 실제 추천 로직 구현
    resp_data = RecommendationResponseData(
        group_id=event.payload.dining_data.groups_id,
        recommendation_count=1,
        recommended_items=[
            RecommendedItem(
                restaurant_id="1",
                reasoning_description="test"
            )
        ]
    )

    await service.publish_recommendation_response(event, message.raw_message.key, resp_data)

# 페르소나 요청
@broker.subscriber(service.get_persona_request_topic())
async def handle_persona(event: PersonaRequestPayload, message = Context()):
    print("get persona request")
    print(event)

# 메인 함수
async def main():
    await app.run()

if __name__ == "__main__":
    asyncio.run(main())