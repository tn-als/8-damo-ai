# dev/test/shared/test_database.py
import pytest
from datetime import datetime
import uuid

@pytest.mark.asyncio
async def test_db_create_and_read(db_manager):
    db_manager.set_collection("test_unit")
    
    unique_name = f"Test Restaurant {uuid.uuid4().hex[:8]}"
    now = datetime.now()
    test_data = {
        "name": unique_name, 
        "rating": 4.5,
        "created_at": now
    }
    
    inserted_id = await db_manager.create_one(test_data)
    assert inserted_id is not None
    
    read_data = await db_manager.read_one({"name": unique_name})
    assert read_data is not None
    assert "created_at" in read_data
    # 저장된 시간과 생성 시점의 시간이 거의 일치하는지 확인 (초 단위)
    assert abs((read_data["created_at"] - now).total_seconds()) < 1

@pytest.mark.asyncio
async def test_db_update(db_manager):
    db_manager.set_collection("test_unit")
    
    unique_name = f"Update Test Restaurant {uuid.uuid4().hex[:8]}"
    create_time = datetime.now()
    await db_manager.create_one({
        "name": unique_name, 
        "rating": 3.0,
        "created_at": create_time
    })
    
    # 2. 수정 테스트 (updated_at 추가)
    update_time = datetime.now()
    filter_query = {"name": unique_name}
    update_data = {
        "rating": 5.0,
        "updated_at": update_time
    }
    
    modified_count = await db_manager.update_one(filter_query, update_data)
    assert modified_count > 0
    
    # 3. 수정 확인
    updated_doc = await db_manager.read_one(filter_query)
    assert updated_doc["rating"] == 5.0
    assert "updated_at" in updated_doc
    assert abs((updated_doc["updated_at"] - update_time).total_seconds()) < 1

@pytest.mark.asyncio
async def test_db_phase_increment(db_manager):
    db_manager.set_collection("test_unit")
    
    # 고유한 diningId 생성
    unique_dining_id = f"test_{uuid.uuid4().hex[:8]}"
    
    # 1. 초기 데이터 삽입
    await db_manager.create_one({"diningId": unique_dining_id, "currentPhase": 1})
    
    # 2. 원자적 증가(inc) 테스트
    updated_doc = await db_manager.update_phase_count({"diningId": unique_dining_id}, "currentPhase")
    assert updated_doc is not None
    assert updated_doc["currentPhase"] == 2