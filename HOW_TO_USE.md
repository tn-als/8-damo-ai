# 📖 Damo AI Features 사용 가이드

이 문서는 `dev` 폴더 내의 각 서비스별 로컬 실행, 도커 빌드, 그리고 GHCR 업데이트 방법에 대해 설명합니다.

---

## 1. 공통 환경 설정

모든 서비스 실행 전, `dev` 폴더 루트에 `.env` 파일이 존재해야 합니다.
`.env.local` 파일을 복사해서 `.env`로 이름 변경 뒤 키값을 넣어 사용하시면 됩니다.

---

## 2. 서비스별 로컬 실행 (Local Execution)

각 서비스는 `uvicorn`을 사용하여 개별적으로 실행할 수 있습니다.

| 서비스명 | 포트 | 실행 명령어 |
| :--- | :--- | :--- |
| **Gateway** | 8000 | `uvicorn gateway.main:app --host 0.0.0.0 --port 8000 --reload` |
| **Core Service** | 8001 | `uvicorn services.core_service.app.main:app --host 0.0.0.0 --port 8001 --reload` |
| **Recommendation** | 8002 | `uvicorn services.recommendation.app.main:app --host 0.0.0.0 --port 8002 --reload` |
| **Iterative Discussion** | 8003 | `uvicorn services.iterative_discussion.app.main:app --host 0.0.0.0 --port 8003 --reload` |

> **팁:** `sh run_dev.sh` 스크립트를 사용하면 메뉴 방식으로 간편하게 실행할 수 있습니다.

---

## 3. 도커 빌드 및 실행 (Docker Build & Run)

TBA

---

## 4. GHCR (GitHub Container Registry) 업데이트

TBA

---

## 5. 테스트 실행

`test` 폴더 내의 테스트 코드를 실행하여 각 모듈 및 서비스의 정상 동작을 확인합니다.

```bash
# 전체 테스트 실행
pytest test/

# 특정 테스트 파일 실행
pytest test/shared/test_monitoring.py
```
